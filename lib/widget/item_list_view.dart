import 'package:apiproject/model/post.dart';

import 'package:apiproject/theme.dart';
import 'package:apiproject/widget/user_widget.dart';

import 'package:flutter/material.dart';

class ItemListViewWidget extends StatelessWidget {
  const ItemListViewWidget({
    super.key,
    required this.postFuture,
  });

  final Future<List<Post>> postFuture;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Post>>(
        future: postFuture,
        builder: (context, snapshot) {
          // showing a loader while waiting for the data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            //we have the data, do stuff here
            final usersData = snapshot.data!;
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: kSectionSpacingSm),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: kSectionSpacingSm,
                  mainAxisSpacing: kSectionSpacingMd,
                  childAspectRatio: 0.8,
                  children: [
                    for (final item in usersData) UserWidget(postData: item),
                  ]),
            );
          } else {
            return const Text("No data available");
          }
        },
      ),
    );
  }
}
