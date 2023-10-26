import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apiproject/api_service.dart';
import 'package:apiproject/model/post.dart';
import 'package:apiproject/theme.dart';

class DetailsSecondPage extends StatefulWidget {
  final int id;
  final Function refreshCallback;
  const DetailsSecondPage(
      {Key? key, required this.id, required this.refreshCallback})
      : super(key: key);

  @override
  _DetailsSecondPageState createState() => _DetailsSecondPageState();
}

class _DetailsSecondPageState extends State<DetailsSecondPage> {
  final ApiService apiService = ApiService();
  //final TextEditingController nameController = TextEditingController();
  Post? detailsPost;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      final post = await apiService.getDetailsPost(widget.id);
      setState(() {
        detailsPost = post;
      });
    } catch (e) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Pet'),
      ),
      body: detailsPost == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kScreenPadding,
                vertical: kScreenPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Image.network(
                          detailsPost!.imageUrl,
                          height: 100,
                          width: 100,
                        ),
                      ),
                      const SizedBox(
                        width: kScreenPadding,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kScreenPadding),
                            child: Text('Name: ${detailsPost!.name}'),
                          ),
                          const SizedBox(height: kScreenPadding),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kScreenPadding),
                            child: Text(
                                'Last Seen: ${detailsPost!.lastSeen.toString()}'),
                          ),
                          const SizedBox(height: kScreenPadding),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kScreenPadding),
                            child: Text(
                                'Description: ${detailsPost!.description}'),
                          ),
                          const SizedBox(height: kScreenPadding),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kScreenPadding),
                            child: Text('Location : ${detailsPost!.location}'),
                          ),
                          const SizedBox(height: kScreenPadding),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kScreenPadding),
                            child: InputChip(
                              label: Text(
                                detailsPost!.isFound ? 'Found' : 'Lost',
                                style: const TextStyle(color: Colors.black),
                              ),
                              avatar: Icon(
                                detailsPost!.isFound
                                    ? CupertinoIcons.check_mark_circled_solid
                                    : CupertinoIcons.clear_circled_solid,
                                color:
                                    Colors.black, // Set your desired icon color
                              ),
                              onSelected: (bool newBool) {
                                setState(() {
                                  try {
                                    detailsPost!.isFound =
                                        !detailsPost!.isFound;
                                  } catch (e) {
                                    rethrow;
                                  }
                                });
                              },
                              selected: detailsPost!.isFound,
                              selectedColor: Colors.greenAccent,
                              //disabledColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kScreenPadding, vertical: kScreenPadding),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() async {
                                  try {
                                    await apiService.updatePost(
                                        widget.id, detailsPost!.isFound);
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Post updated successfully!"),
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
                                    await apiService.deletePost(widget.id);
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Post deleted successfully!"),
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
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
