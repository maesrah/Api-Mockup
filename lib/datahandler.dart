import 'dart:convert';

import 'package:apiproject/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataHandler {
  Future<void> deleteData(BuildContext context, int id) async {
    try {
      final response = await http.delete(Uri.parse(
          'https://6531e4b14d4c2e3f333d5db9.mockapi.io/api/v1/posts/$id'));

      if (!context.mounted) return;
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Succesfully')));
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateData(BuildContext context, int id) async {
    try {
      final response = await http.put(
          Uri.parse(
              'https://6531e4b14d4c2e3f333d5db9.mockapi.io/api/v1/posts/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            'name': 'hi',
            'username': 'meow',
            'userId': 1,
          }));

      if (!context.mounted) return;
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Succesfully')));
        print(response.body);
      } else {
        throw Exception('Failed to update data');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> sendPostRequest(
      BuildContext context, String name, String username) async {
    var apiUrl =
        Uri.parse("https://6531e4b14d4c2e3f333d5db9.mockapi.io/api/v1/posts");
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

    //When a BuildContext is used, its mounted
    //property must be checked after an asynchronous gap.
    if (!context.mounted) return;
    //201 indicate a succesful creation
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Post created successfully!"),
      ));
      Navigator.of(context).pop();
      print(response.body);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to create post!"),
      ));
    }
  }

  static Future<List<Users>> getUsers() async {
    var url =
        Uri.parse("https://6531e4b14d4c2e3f333d5db9.mockapi.io/api/v1/posts");
    // final response =
    //     await http.get(url, headers: {"Content-Type": "application/json"});
    final response = await http.get(url);
    final List body = json.decode(response.body);
    return body.map((e) => Users.fromJson(e)).toList();
  }
}
