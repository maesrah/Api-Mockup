import 'package:apiproject/api_service.dart';
import 'package:apiproject/model/post.dart';
import 'package:apiproject/model/user.dart';
import 'package:apiproject/screen/details_page.dart';
import 'package:apiproject/theme.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatefulWidget {
  final Post postData;
  const UserWidget({super.key, required this.postData});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  ApiService dataHandler = ApiService();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      postData: widget.postData,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(widget.postData.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(children: [
          Align(
            alignment: Alignment.topRight,
            child: InputChip(
              label: Text(
                widget.postData.isFound ? 'Found' : 'Lost',
                style: const TextStyle(color: Colors.black),
              ),
              avatar: Icon(
                widget.postData.isFound
                    ? CupertinoIcons.check_mark_circled_solid
                    : CupertinoIcons.clear_circled_solid,
                color: Colors.black, // Set your desired icon color
              ),
              selected: widget.postData.isFound,
              selectedColor: Colors.greenAccent,
              disabledColor: Theme.of(context).primaryColor,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSectionSpacingSm, vertical: kSectionSpacingSm),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kSectionSpacingSm),
                      child: Text(
                        widget.postData.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: kSectionSpacingSm),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kSectionSpacingSm),
                      child: Text(
                        widget.postData.location,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),

        // child: Column(children: [
        //   Padding(
        //     padding: const EdgeIn sets.all(8.0),
        //     child: Text(widget.userData.name),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(widget.userData.location),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(widget.userData.lastSeen.toString()),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(widget.userData.description),
        //   ),
        //   ElevatedButton(
        //     onPressed: () {
        //       setState(() {
        //         dataHandler.deleteData(context, int.parse(widget.userData.id));
        //       });
        //     },
        //     child: const Text('Delete Data'),
        //   ),
        //   ElevatedButton(
        //     onPressed: () {
        //       setState(() {
        //         dataHandler.updateData(context, int.parse(widget.userData.id));
        //       });
        //     },
        //     child: const Text('Update Data'),
        //   ),
        // ]),
      ),
    );
  }
}
