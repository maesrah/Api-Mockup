import 'package:apiproject/api_service.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  // final meow="https://jsonplaceholder.typicode.com/posts";
  var apiUrl = Uri.parse("https://jsonplaceholder.typicode.com/users");

  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Post Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(hintText: "Username"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  apiService.sendPostRequest(
                      context, nameController.text, userNameController.text);
                });
              },
              child: const Text("Create Post"),
            ),
          ],
        ),
      ),
    );
  }
}
