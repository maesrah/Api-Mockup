import 'package:apiproject/api_service.dart';
import 'package:apiproject/component/add_lost.button.dart';
import 'package:apiproject/component/tab_widget.dart';
import 'package:apiproject/widget/lost_found_widget.dart';
import 'package:apiproject/widget/paged_grid_view.widget.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LostAndFoundLogoWidget(),
          CustomTabBarWidget(),
          // ItemListViewWidget(postFuture: apiService.getPosts()),
          PagedGridViewWidget(),
        ]),
        floatingActionButton: AddLostPetButton());
  }
}
