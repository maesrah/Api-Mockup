import 'package:apiproject/api_service.dart';
import 'package:apiproject/model/post.dart';
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
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController lastSeenController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  ApiService apiService = ApiService();
  final int _idCounter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Your Lost Cats"),
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
              controller: descriptionController,
              decoration: const InputDecoration(hintText: "Description"),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(hintText: "Location"),
            ),
            TextField(
              controller: lastSeenController,
              decoration: const InputDecoration(hintText: "lastSeen"),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(hintText: "Image"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() async {
                  try {
                    await apiService.createPost(Post(
                        id: _idCounter.toString(),
                        name: nameController.text,
                        lastSeen: int.parse(lastSeenController.text),
                        description: descriptionController.text,
                        location: locationController.text,
                        imageUrl: imageController.text,
                        isFound: false));
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Post created successfully!"),
                    ));
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } catch (e) {
                    // ignore: use_build_context_synchronously
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
