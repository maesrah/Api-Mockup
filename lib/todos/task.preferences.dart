import 'package:apiproject/todos/todo.model.dart';
import 'package:apiproject/todos/todo.page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const _taskKey = 'tasks';

class TaskPreference extends StatefulWidget {
  const TaskPreference({Key? key}) : super(key: key);

  @override
  TaskPreferenceState createState() => TaskPreferenceState();
}

class TaskPreferenceState extends State<TaskPreference> {
  Iterable<Task> _tasks = List.unmodifiable([]);
  final _taskNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

//store each task as an individual string within a list
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();

    //individual JSON strings for each task
    List<String> taskListString =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();

    prefs.setStringList(_taskKey, taskListString);

    setState(() {});
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? taskListString = prefs.getStringList(_taskKey);
    if (taskListString != null) {
      _tasks = taskListString
          .map((task) => Task.fromJson(json.decode(task)))
          .toList();
    }
    setState(() {});
    //
  }

  void createTask(String name) {
    final newTask = Task(name: name);
    //_tasks.add(newTask);

    final newTaskList = [
      newTask,
      ..._tasks,
    ];
    _tasks = newTaskList;
    _saveTasks();
  }

  void deleteTask(String taskName) {
    // _tasks.removeWhere((item) => item.name == taskName);

    // final updatedTasks = [
    //   ..._tasks,
    // ];

    // _tasks = updatedTasks;

    _tasks = _tasks.where((item) => item.name != taskName);

    _saveTasks();
  }

  void updateTask(String taskName) {
    _tasks = _tasks.map((item) {
      if (item.name == taskName) {
        return Task(
          name: item.name,
          isDone: !item.isDone,
        );
      }

      return item;
    }).toList();

    _saveTasks();
  }

  @override
  void dispose() {
    super.dispose();
    _taskNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TodoAppPage(
      tasks: _tasks.toList(),
      taskNameController: _taskNameController,
      deleteTask: deleteTask,
      updateTask: updateTask,
      createTask: createTask,
    );
  }
}
