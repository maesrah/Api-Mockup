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
                  try {
                    apiService.sendPostRequest(
                        nameController.text, userNameController.text);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Post created successfully!"),
                    ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Failed to create post!"),
                    ));
                  }
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
