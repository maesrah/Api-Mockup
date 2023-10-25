import 'package:flutter/material.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
    );
  }
}
