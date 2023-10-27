import 'package:apiproject/todos/todo.model.dart';
import 'package:apiproject/todos/todo.page.dart';
import 'package:flutter/material.dart';

class TodoAppController extends StatefulWidget {
  const TodoAppController({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TodoAppControllerState createState() => _TodoAppControllerState();
}

class _TodoAppControllerState extends State<TodoAppController> {
  List<Task> _tasks = [];
  final _taskNameController = TextEditingController();

  void createTask(String name) {
    final newTask = Task(name: name);

    final newTaskList = [
      newTask,
      ..._tasks,
    ];

    setState(() {
      _tasks = newTaskList;
    });
  }

  void deleteTask(String taskName) {
    _tasks.removeWhere((item) => item.name == taskName);

    final updatedTasks = [
      ..._tasks,
    ];

    setState(() {
      _tasks = updatedTasks;
    });
  }

  void updateTask(String taskName) {
    final updatedTasks = _tasks.map((item) {
      if (item.name == taskName) {
        return Task(
          name: item.name,
          isDone: !item.isDone,
        );
      }

      return item;
    }).toList();

    setState(() {
      _tasks = updatedTasks;
    });
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
