import 'package:apiproject/component/add_lost_button.dart';
import 'package:apiproject/component/tab_widget.dart';

import 'package:apiproject/widget/lost_found_widget.dart';

import 'package:apiproject/widget/paged_grid_view_widget.dart';

//import 'package:apiproject/widget/user_widget.dart';

import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  //DataHandler dataHandler = DataHandler();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LostAndFoundLogoWidget(),
          CustomTabBarWidget(),
          //ItemListViewWidget(usersFuture: apiService.getUsers())
          PagedGridViewWidget(),
        ]),
        floatingActionButton: AddLostPetButton()
        // FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const PostPage()));
        //   },

        // ),
        );
  }
}
