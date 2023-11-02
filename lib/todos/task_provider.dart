import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:apiproject/todos/task_api.service.dart';
import 'package:apiproject/todos/task_cache.service.dart';
import 'package:apiproject/todos/task.model.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Task> taskList = [];
  final taskNameController = TextEditingController();
  final taskCacheService = TaskCacheService();
  final taskAPIService = TaskApiService();
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(taskList);

  void loadTasks() async {
    final tasksFromStorage = await taskCacheService.loadTasks();
    taskList = tasksFromStorage;
    final tasksFromNetwork = await taskAPIService.getTasks();
    taskList = tasksFromNetwork;
    isLoading = false;
    notifyListeners();

    taskCacheService.saveTasks(tasksFromNetwork);
  }

  void createTask(String name) async {
    try {
      isLoading = true;
      notifyListeners();
      final newTask = await taskAPIService.createTask(name: name);

      final newTaskList = [
        newTask,
        ...taskList,
      ];

      taskList = newTaskList;

      isLoading = false;
      notifyListeners();

      taskCacheService.saveTasks(taskList);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void deleteTask(String id) async {
    try {
      isLoading = true;
      notifyListeners();

      await taskAPIService.deleteTask(id);
      taskList.removeWhere((item) => item.id == id);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }

    taskCacheService.saveTasks(taskList);
  }

  void updateTask(String id) async {
    try {
      isLoading = true;
      Task? updatedTask;

      final updatedTasks = taskList.map((item) {
        if (item.id == id) {
          updatedTask = Task(
            id: id,
            name: item.name,
            isDone: !item.isDone,
          );
          return updatedTask!;
        }

        return item;
      }).toList();

      if (updatedTask == null) return;

      await taskAPIService.updateTask(
        id,
        updatedTask!.isDone,
      );

      taskList = updatedTasks;
      isLoading = false;
      notifyListeners();
      taskCacheService.saveTasks(taskList);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
    taskNameController.dispose();
  }
}
