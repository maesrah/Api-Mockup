import 'dart:convert';

import 'package:apiproject/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      'https://6531e4b14d4c2e3f333d5db9.mockapi.io/api/v1/posts';
  Future<void> deleteData(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateData(int id) async {
    try {
      final response = await http.put(Uri.parse('$baseUrl/$id'),
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

  Future<void> sendPostRequest(String name, String username) async {
    try {
      var apiUrl = Uri.parse(baseUrl);
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

      // 201 indicates a successful creation
      if (response.statusCode == 201) {
      } else {
        throw Exception("Failed to create post");
      }
    } catch (e) {
      rethrow; // Rethrow the error for handling in the widget
    }
  }

  Future<List<Users>> getUsers() async {
    var url = Uri.parse(baseUrl);
    // final response =
    //     await http.get(url, headers: {"Content-Type": "application/json"});
    final response = await http.get(url);
    final List body = json.decode(response.body);
    return body.map((e) => Users.fromJson(e)).toList();
  }
}
