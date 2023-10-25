import 'package:apiproject/widget/item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:apiproject/api_service.dart';
import 'package:apiproject/model/post.dart';
import 'package:apiproject/theme.dart';

class DetailsPage extends StatefulWidget {
  final int id;

  DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ApiService apiService = ApiService();

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Pet'),
      ),
      body: FutureBuilder<Post>(
        future: apiService.getDetailsPost(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No data available');
          }
          final detailsPost = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kScreenPadding,
              vertical: kScreenPadding,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.network(
                        detailsPost.imageUrl,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      width: kScreenPadding,
                    ),
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width - 200,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(hintText: detailsPost.name),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() async {
                        try {
                          await apiService.updatePost(
                              widget.id, nameController.text);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Post updated successfully!"),
                          ));
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Failed to update post!"),
                          ));
                        }
                      });
                    },
                    child: const Text('Update')),
                ElevatedButton(
                    onPressed: () {
                      setState(() async {
                        try {
                          await apiService.deletePost(widget.id);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Post deleted successfully!"),
                          ));
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Failed to create post!"),
                          ));
                        }
                      });
                    },
                    child: const Text('Delete'))
              ],
            ),
          );
        },
      ),
    );
  }
}
