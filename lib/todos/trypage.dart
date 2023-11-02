import 'package:apiproject/theme.dart';
import 'package:apiproject/todos/task.model.dart';
import 'package:apiproject/todos/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef TaskOperationCallback = Future<void> Function(String);

class TryAppPage extends StatefulWidget {
  const TryAppPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TryAppPage> createState() => _TryAppPageState();
}

class _TryAppPageState extends State<TryAppPage> {
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          TodoCount(tasks: taskProvider.tasks),
          const SizedBox(width: kSectionSpacingSm),
          if (isLoading)
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
                            taskProvider.updateTask(task.id);
                          }),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            taskProvider.deleteTask(task.id);
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
                        // Handle the error here, e.g., show an error message to the user.
                        print('Error creating task: $e');
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
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(child: Text(tasks.length.toString()));
  }
}
