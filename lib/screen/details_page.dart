import 'package:apiproject/model/post.dart';

import 'package:apiproject/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Post postData;
  const DetailsPage({super.key, required this.postData});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Pet'),
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kScreenPadding, vertical: kScreenPadding),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0), // Border radius
                  ),
                  child: Image.network(
                    widget.postData.imageUrl,
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
                    decoration: InputDecoration(hintText: widget.postData.name),
                  ),
                ),
                // FloatingActionButton(onPressed: setState(() {
                //   api
                // });
                // )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
