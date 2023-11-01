import 'package:apiproject/theme.dart';
import 'package:apiproject/todos/task.model.dart';
import 'package:flutter/material.dart';

typedef TaskOperationCallback = Future<void> Function(String);

class TaskAppPage extends StatefulWidget {
  const TaskAppPage({
    Key? key,
    required this.tasks,
    required this.taskNameController,
    required this.deleteTask,
    required this.updateTask,
    required this.createTask,
    required this.loadTasks,
  }) : super(key: key);

  final List<Task> tasks;
  final TextEditingController taskNameController;
  final TaskOperationCallback deleteTask;
  final TaskOperationCallback updateTask;
  final TaskOperationCallback createTask;
  final Future<void> Function() loadTasks;

  @override
  State<TaskAppPage> createState() => _TaskAppPageState();
}

class _TaskAppPageState extends State<TaskAppPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    widget.loadTasks().then((value) {
      setState(() => isLoading = false);
    }).catchError((e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          TodoCount(tasks: widget.tasks),
          const SizedBox(width: kSectionSpacingSm),
          if (isLoading)
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      body: ListView(
        children: widget.tasks.isEmpty
            ? const [
                ListTile(title: Text('Empty')),
              ] as List<Widget>
            : widget.tasks.map((task) {
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
                        onPressed: () async {
                          try {
                            setState(() => isLoading = true);

                            await widget.updateTask(task.id);

                            setState(() => isLoading = false);
                          } catch (e) {
                            if (!context.mounted) return;

                            setState(() => isLoading = false);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          try {
                            setState(() => isLoading = true);

                            await widget.deleteTask(task.id);

                            setState(() => isLoading = false);
                          } catch (e) {
                            if (!context.mounted) return;

                            setState(() => isLoading = false);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                      ),
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
                content: TextField(controller: widget.taskNameController),
                actions: [
                  OutlinedButton(
                    onPressed: Navigator.of(context).maybePop,
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() => isLoading = true);

                        await widget.createTask(widget.taskNameController.text);

                        setState(() => isLoading = false);
                      } catch (e) {
                        if (!context.mounted) return;

                        setState(() => isLoading = false);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
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

          widget.taskNameController.clear();
        },
        child: const Text('Add'),
      ),
    );
  }
}

class TodoCount extends StatelessWidget {
  const TodoCount({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(child: Text(tasks.length.toString()));
  }
}
