import 'package:apiproject/theme.dart';

import 'package:apiproject/todos/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef TaskOperationCallback = Future<void> Function(String);

class TaskPage extends StatefulWidget {
  const TaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          const TodoCount(),
          const SizedBox(width: kSectionSpacingSm),
          if (taskProvider.isLoading)
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      body: ListView(
        children: taskProvider.taskList.isEmpty
            ? const [
                ListTile(title: Text('Empty')),
              ] as List<Widget>
            : taskProvider.taskList.map((task) {
                return ListTile(
                  title: Text(
                    task.name,
                    style: TextStyle(
                      decoration:
                          task.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton(
                          child: Text(
                            'Mark ${(task.isDone ? 'Undone' : 'Done')}',
                          ),
                          onPressed: () {
                            try {
                              taskProvider.updateTask(task.id);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            try {
                              taskProvider.deleteTask(task.id);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }),
                    ],
                  ),
                );
              }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add new task'),
                content: TextField(controller: taskProvider.taskNameController),
                actions: [
                  OutlinedButton(
                    onPressed: Navigator.of(context).maybePop,
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        taskProvider
                            .createTask(taskProvider.taskNameController.text);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                      if (!context.mounted) return;

                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );

          taskProvider.taskNameController.clear();
        },
        child: const Text('Add'),
      ),
    );
  }
}

class TodoCount extends StatelessWidget {
  const TodoCount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return CircleAvatar(child: Text(taskProvider.tasks.length.toString()));
  }
}
