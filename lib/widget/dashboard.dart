import 'package:apiproject/datahandler.dart';
import 'package:apiproject/theme.dart';
import 'package:apiproject/widget/item_list_view.dart';
import 'package:apiproject/widget/lost_found_widget.dart';
import 'package:apiproject/widget/post_page.dart';
import 'package:apiproject/model/user.dart';
import 'package:apiproject/widget/user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  //DataHandler dataHandler = DataHandler();
  final Future<List<Users>> usersFuture = DataHandler.getUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LostAndFoundLogoWidget(),
          DefaultTabController(
            length: 3,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 2.0,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Theme.of(context).secondaryHeaderColor,
              tabs: [
                Tab(
                  child: Text(
                    'CATS',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Tab(
                  child: Text(
                    'DOGS',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Tab(
                  child: Text(
                    'OTHERS',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          ItemListViewWidget(usersFuture: usersFuture),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PostPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
