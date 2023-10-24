import 'package:apiproject/datahandler.dart';
import 'package:apiproject/model/user.dart';
import 'package:apiproject/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatefulWidget {
  final Users userData;
  const UserWidget({super.key, required this.userData});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  DataHandler dataHandler = DataHandler();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(widget.userData.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(children: [
        Align(
          alignment: Alignment.topRight,
          child: InputChip(
            label: Text(
              widget.userData.isFound ? 'Found' : 'Lost',
              style: TextStyle(color: Colors.black),
            ),
            avatar: Icon(
              widget.userData.isFound
                  ? CupertinoIcons.check_mark_circled_solid
                  : CupertinoIcons.clear_circled_solid,
              color: Colors.black, // Set your desired icon color
            ),
            selected: widget.userData.isFound,
            selectedColor: Colors.greenAccent,
            disabledColor: Colors.redAccent,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kScreenPadding, vertical: kScreenPaddingLg),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kSectionSpacingSm, vertical: kSectionSpacingLg),
                child: Text(
                  widget.userData.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kScreenPadding, vertical: kScreenPadding),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kSectionSpacingSm, vertical: kSectionSpacingSm),
                child: Text(
                  widget.userData.lastSeen.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ]),

      // child: Column(children: [
      //   Padding(
      //     padding: const EdgeIn                                                                                                                                                                   \     ] \   q d    Q
      // ]'    '

      //    ' D    X    XQ    x sets.all(8.0),
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
    );
  }
}
