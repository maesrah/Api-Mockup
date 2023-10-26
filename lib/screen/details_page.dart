import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apiproject/api_service.dart';
import 'package:apiproject/model/post.dart';
import 'package:apiproject/theme.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  final Function refreshCallback;
  const DetailsPage({Key? key, required this.id, required this.refreshCallback})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ApiService apiService = ApiService();

  final TextEditingController nameController = TextEditingController();
  bool isSelected = false;
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

          //bool isSelected = detailsPost.isFound;
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
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width - 200,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(hintText: detailsPost.name),
                      ),
                    ),
                  ],
                ),
                Text(detailsPost.lastSeen.toString()),
                Text(detailsPost.description),
                Text(detailsPost.location),
                InputChip(
                  label: Text(
                    isSelected ? 'Found' : 'Lost',
                    style: const TextStyle(color: Colors.black),
                  ),
                  avatar: Icon(
                    isSelected
                        ? CupertinoIcons.check_mark_circled_solid
                        : CupertinoIcons.clear_circled_solid,
                    color: Colors.black, // Set your desired icon color
                  ),
                  onSelected: (bool newBool) {
                    setState(() {
                      try {
                        isSelected = !isSelected;
                        detailsPost.isFound = newBool;
                        print(detailsPost.isFound);
                      } catch (e) {
                        rethrow;
                      }
                    });
                  },
                  selected: isSelected,
                  selectedColor: Colors.greenAccent,
                  //disabledColor: Theme.of(context).primaryColor,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() async {
                        try {
                          await apiService.updatePost(
                              widget.id, detailsPost.isFound);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Post updated successfully!"),
                          ));
                          widget.refreshCallback();
                          if (!context.mounted) return;
                          Navigator.pop(context);
                        } catch (e) {
                          if (!context.mounted) return;
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
                          detailsPost.isFound = isSelected;
                          await apiService.deletePost(widget.id);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Post deleted successfully!"),
                          ));
                          widget.refreshCallback();
                          if (!context.mounted) return;
                          Navigator.pop(context);
                        } catch (e) {
                          if (!context.mounted) return;
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
