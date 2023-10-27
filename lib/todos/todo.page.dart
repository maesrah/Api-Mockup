import 'package:apiproject/todos/todo.model.dart';
import 'package:flutter/material.dart';

typedef TaskOperationCallback = void Function(String);

class TodoAppPage extends StatelessWidget {
  const TodoAppPage({
    Key? key,
    required this.tasks,
    required this.taskNameController,
    required this.deleteTask,
    required this.updateTask,
    required this.createTask,
  }) : super(key: key);

  final List<Task> tasks;
  final TextEditingController taskNameController;
  final TaskOperationCallback deleteTask;
  final TaskOperationCallback updateTask;
  final TaskOperationCallback createTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [TodoCount(tasks: tasks)],
      ),
      body: ListView(
        children: tasks.isEmpty
            ? const [
                ListTile(title: Text('Empty')),
              ] as List<Widget>
            : tasks.map((task) {
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
                        child:
                            Text('Mark ${(task.isDone ? 'Undone' : 'Done')}'),
                        onPressed: () => updateTask(task.name),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteTask(task.name),
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
                content: TextField(controller: taskNameController),
                actions: [
                  OutlinedButton(
                    onPressed: Navigator.of(context).maybePop,
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      createTask(taskNameController.text);

                      Navigator.of(context).maybePop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );

          taskNameController.clear();
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
