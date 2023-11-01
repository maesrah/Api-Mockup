import 'package:apiproject/todos/task_api.service.dart';
import 'package:apiproject/todos/task_cache.service.dart';
import 'package:apiproject/todos/task.model.dart';
import 'package:apiproject/todos/task.page.dart';
import 'package:flutter/material.dart';

class TaskController extends StatefulWidget {
  const TaskController({Key? key}) : super(key: key);

  @override
  TaskControllerState createState() => TaskControllerState();
}

class TaskControllerState extends State<TaskController> {
  Iterable<Task> _tasks = List.unmodifiable([]);
  final _taskNameController = TextEditingController();
  final _taskCacheService = TaskCacheService();
  final _taskAPIService = TaskApiService();

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadTasks() async {
    final tasksFromStorage = await _taskCacheService.loadTasks();

    setState(() => _tasks = tasksFromStorage);

    final tasksFromNetwork = await _taskAPIService.getTasks();

    setState(() {
      _tasks = tasksFromNetwork;
    });

    _taskCacheService.saveTasks(tasksFromNetwork);
  }

  Future<void> createTask(String name) async {
    final newTask = await _taskAPIService.createTask(name: name);

    final newTaskList = [
      newTask,
      ..._tasks,
    ];

    setState(() {
      _tasks = newTaskList;
    });

    _taskCacheService.saveTasks(_tasks.toList());
  }

  Future<void> deleteTask(String id) async {
    await _taskAPIService.deleteTask(id);

    setState(() {
      _tasks = _tasks.where((item) => item.id != id);
    });

    _taskCacheService.saveTasks(_tasks.toList());
  }

  Future<void> updateTask(String id) async {
    Task? updatedTask;

    final updatedTasks = _tasks.map((item) {
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

    await _taskAPIService.updateTask(
      id,
      updatedTask!.isDone,
    );

    setState(() {
      _tasks = updatedTasks;
    });

    _taskCacheService.saveTasks(_tasks.toList());
  }

  @override
  void dispose() {
    super.dispose();
    _taskNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TaskAppPage(
      tasks: _tasks.toList(),
      taskNameController: _taskNameController,
      loadTasks: loadTasks,
      deleteTask: deleteTask,
      updateTask: updateTask,
      createTask: createTask,
    );
  }
}
