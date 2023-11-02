import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:apiproject/todos/task_api.service.dart';
import 'package:apiproject/todos/task_cache.service.dart';
import 'package:apiproject/todos/task.model.dart';

class TaskProvider extends ChangeNotifier {
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
    notifyListeners();

    taskCacheService.saveTasks(tasksFromNetwork);
  }

  void createTask(String name) async {
    final newTask = await taskAPIService.createTask(name: name);
    taskList.insert(0, newTask);
    notifyListeners();
    taskCacheService.saveTasks(taskList);
  }

  void deleteTask(String id) async {
    await taskAPIService.deleteTask(id);
    taskList.removeWhere((item) => item.id == id);
    notifyListeners();
    taskCacheService.saveTasks(taskList);
  }

  void updateTask(String id) async {
    final updatedTaskIndex = taskList.indexWhere((item) => item.id == id);

    if (updatedTaskIndex == -1) return;

    final updatedTask = taskList[updatedTaskIndex];
    taskList[updatedTaskIndex] = Task(
      id: updatedTask.id,
      name: updatedTask.name,
      isDone: !updatedTask.isDone,
    );

    await taskAPIService.updateTask(id, taskList[updatedTaskIndex].isDone);
    notifyListeners();
    taskCacheService.saveTasks(taskList);
  }

  @override
  void dispose() {
    super.dispose();
    taskNameController.dispose();
  }
}
