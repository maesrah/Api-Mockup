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

  Future<Post> updatePost(int id, bool isFound) async {
    try {
      final response = await http.put(Uri.parse('$_baseUrl/posts/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(<String, dynamic>{
            'isFound': isFound,
          }));

      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to update data');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createPost(Post post) async {
    //post.toJson();
    var apiUrl = Uri.parse('$_baseUrl/posts');
    await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        post.toJson(),
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

  Future<Post> getDetailsPost(int id) async {
    var url = Uri.parse('$_baseUrl/posts/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      return Post.fromJson(body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
