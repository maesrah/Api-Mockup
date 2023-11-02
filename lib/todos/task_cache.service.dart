import 'dart:convert';

import 'package:apiproject/todos/task.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _taskKey = 'tasks';

class TaskCacheService {
  // Save tasks into local storage
  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? taskListString =
        tasks.map((task) => jsonEncode(task.toJson())).toList();

    prefs.setStringList(_taskKey, taskListString);
  }

  // Fetch tasks from local storage
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? taskListString = prefs.getStringList(_taskKey);

    if (taskListString != null) {
      return taskListString
          .map((task) => Task.fromJson(json.decode(task)))
          .toList();
    } else {
      return [];
    }
  }
}
