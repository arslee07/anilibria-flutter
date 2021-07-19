import 'package:anilibria/controller/catalog_controller.dart';
import 'package:anilibria/controller/search_controller.dart';
import 'package:anilibria/ui/catalog/catalog_page_app_bar.dart';
import 'package:anilibria/ui/catalog/catalog_page_title_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogPage extends StatelessWidget {
  final SearchController searchController = Get.find();
  final CatalogController catalogController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CatalogPageAppBar(),
        body: RefreshIndicator(
          onRefresh: () async => await catalogController.fetchList(),
          child: catalogController.obx(
              (state) => CatalogPageTitleList(state: state),
              onError: (error) => ListView(children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('бля ошибка =(\n\n\n$error'),
                      ),
                    ),
                  ])),
        ));
  }
}
