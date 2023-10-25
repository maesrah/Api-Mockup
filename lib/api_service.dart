import 'dart:convert';
import 'package:apiproject/model/post.dart';

import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://6531e4b14d4c2e3f333d5db9.mockapi.io/api/v1';

  Future<void> deletePost(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/posts/$id'));

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updatePost(int id) async {
    try {
      final response = await http.put(Uri.parse('$_baseUrl/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            'name': 'hi',
            'username': 'meow',
            'userId': 1,
          }));

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to update data');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createPost(String name, String username) async {
    var apiUrl = Uri.parse('$_baseUrl/posts');
    var response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "name": name,
          "username": username,
          "userId": 1,
        },
      ),
    );
  }

  Future<List<Post>> getPosts() async {
    var url = Uri.parse('$_baseUrl/posts');
    // final response =
    //     await http.get(url, headers: {"Content-Type": "application/json"});
    final response = await http.get(url);
    final List body = json.decode(response.body);
    return body.map((e) => Post.fromJson(e)).toList();
  }
}
