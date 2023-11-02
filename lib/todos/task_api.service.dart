import 'dart:convert';

import 'package:apiproject/todos/task.model.dart';
import 'package:http/http.dart' as http;

class TaskApiService {
  final String _baseUrl = 'https://6531e4b14d4c2e3f333d5db9.mockapi.io/api/v1';

  Future<void> deleteTask(String id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/tasks/$id'));

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<Task> updateTask(String id, bool isDone) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/tasks/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(<String, dynamic>{
          'isDone': isDone,
        }),
      );

      if (response.statusCode == 200) {
        return Task.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to update data');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<Task> createTask({required String name}) async {
    var apiUrl = Uri.parse('$_baseUrl/tasks');
    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
      }),
    );

    return Task.fromJson(jsonDecode(response.body));
  }

  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(seconds: 2));

    var url = Uri.parse('$_baseUrl/tasks');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List body = json.decode(response.body);
      final bodyTyped = body.map((e) => Task.fromJson(e)).toList();

      bodyTyped.sort((a, b) => int.parse(b.id) - int.parse(a.id));

      return bodyTyped;
    } else {
      // Handle non-200 status code, e.g., rate limit exceeded
      print('Request failed with status: ${response.statusCode}');
      return []; // You can return an empty list or handle the error in another way.
    }
  }

  Future<Task> getDetailsTask(String id) async {
    var url = Uri.parse('$_baseUrl/tasks/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      return Task.fromJson(body);
    } else {
      throw Exception('Failed to load Task');
    }
  }
}
