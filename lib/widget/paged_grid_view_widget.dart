import 'package:apiproject/api_service.dart';
import 'package:apiproject/model/post.dart';
import 'package:apiproject/screen/details_page.dart';

import 'package:apiproject/theme.dart';
import 'package:apiproject/widget/user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PagedGridViewWidget extends StatefulWidget {
  const PagedGridViewWidget({
    super.key,
  });

  @override
  State<PagedGridViewWidget> createState() => _PagedGridViewWidgetState();
}

class _PagedGridViewWidgetState extends State<PagedGridViewWidget> {
  ApiService apiService = ApiService();
  int page = 1;
  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((page) {
      fetchNewPage();
    });
    super.initState();
  }

  Future<void> fetchNewPage() async {
    try {
      final newItems = await apiService.getPosts();
      _pagingController.appendPage(newItems, page + 1);
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchNewPage();
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kSectionSpacingSm, vertical: kSectionSpacingSm),
      child: PagedGridView<int, Post>(
        showNewPageProgressIndicatorAsGridChild: false,
        showNewPageErrorIndicatorAsGridChild: false,
        showNoMoreItemsIndicatorAsGridChild: false,
        pagingController: _pagingController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: kSectionSpacingSm,
          mainAxisSpacing: kSectionSpacingMd,
          childAspectRatio: 0.8,
        ),
        builderDelegate: PagedChildBuilderDelegate<Post>(
            itemBuilder: (context, item, index) {
          return UserWidget(postData: item);
        }),
      ),
    ));
  }
}
