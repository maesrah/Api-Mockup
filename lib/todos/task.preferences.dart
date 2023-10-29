import 'package:apiproject/todos/todo.model.dart';
import 'package:apiproject/todos/todo.page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskPreference extends StatefulWidget {
  const TaskPreference({Key? key}) : super(key: key);

  @override
  _TaskPreferenceState createState() => _TaskPreferenceState();
}

class _TaskPreferenceState extends State<TaskPreference> {
  List<Task> _tasks = [];
  final _taskNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  Future<void> _loadTask() async {
    final prefs = await SharedPreferences.getInstance();
    final taskListJson = prefs.getString('tasks');
    if (taskListJson != null) {
      final taskList = jsonDecode(taskListJson);
      final tasks =
          List<Task>.from(taskList.map((taskMap) => Task.fromJson(taskMap)));
      setState(() {
        _tasks = tasks;
      });
    }
  }

  Future<void> _saveTask() async {
    final prefs = await SharedPreferences.getInstance();
    final taskListJson =
        jsonEncode(_tasks.map((task) => task.toJson()).toList());
    prefs.setString('tasks', taskListJson);
    setState(() {});
  }

  void createTask(String name) {
    final newTask = Task(name: name);
    _tasks.add(newTask);
    _saveTask();
  }

  void deleteTask(String taskName) {
    _tasks.removeWhere((item) => item.name == taskName);
    _saveTask();
  }

  void updateTask(String taskName) {
    for (final task in _tasks) {
      if (task.name == taskName) {
        task.isDone = !task.isDone;
      }
    }
    _saveTask();
  }

  @override
  void dispose() {
    super.dispose();
    _taskNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TodoAppPage(
      tasks: _tasks,
      taskNameController: _taskNameController,
      deleteTask: deleteTask,
      updateTask: updateTask,
      createTask: createTask,
    );
  }
}
