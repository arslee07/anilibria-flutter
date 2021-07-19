import 'package:anilibria/controller/search_controller.dart';
import 'package:anilibria/ui/search/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogPageAppBar extends StatelessWidget with PreferredSizeWidget {
  final SearchController controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () =>
            showSearch(context: context, delegate: TitleSearchDelegate()),
      )
    ], title: Text('AniLibria'));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
