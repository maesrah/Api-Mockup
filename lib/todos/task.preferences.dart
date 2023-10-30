import 'package:apiproject/todos/todo.model.dart';
import 'package:apiproject/todos/todo.page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskPreference extends StatefulWidget {
  const TaskPreference({Key? key}) : super(key: key);

  @override
  TaskPreferenceState createState() => TaskPreferenceState();
}

class TaskPreferenceState extends State<TaskPreference> {
  List<Task> _tasks = [];
  final _taskNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTask();
    //readFromSp();
  }

  _loadTask() async {
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

  //store the task list as a single string,
  _saveTask() async {
    final prefs = await SharedPreferences.getInstance();

    //setting the object to string type
    //a single JSON string that represents the entire list of tasks
    final taskListJson =
        jsonEncode(_tasks.map((task) => task.toJson()).toList());

    prefs.setString('tasks', taskListJson);

    setState(() {});
  }

//store each task as an individual string within a list
  saveIntoSp() async {
    final prefs = await SharedPreferences.getInstance();

    //individual JSON strings for each task
    List<String> taskListString =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();

    prefs.setStringList('myData', taskListString);

    setState(() {});
  }

  readFromSp() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? taskListString = prefs.getStringList('myData');
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
    _saveTask();
    saveIntoSp();
  }

  void deleteTask(String taskName) {
    _tasks.removeWhere((item) => item.name == taskName);
    _saveTask();
    saveIntoSp();
  }

  void updateTask(String taskName) {
    for (final task in _tasks) {
      if (task.name == taskName) {
        task.isDone = !task.isDone;
      }
    }
    _saveTask();
    saveIntoSp();
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
