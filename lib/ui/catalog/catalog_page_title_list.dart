import 'package:anilibria/model/title_model.dart';
import 'package:anilibria/ui/catalog/title_item.dart';
import 'package:anilibria/ui/title/title_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogPageTitleList extends StatelessWidget {
  final List<TitleModel>? state;
  final ScrollController scrollController;
  const CatalogPageTitleList(
      {required this.state, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state!.length,
      itemBuilder: (context, index) {
        final TitleModel model = state![index];
        return Padding(
          padding: const EdgeInsets.all(0),
          child: InkWell(
            onTap: () {
              Get.to(() => TitlePage(model: state![index]));
            },
            child: TitleItem(
              thumbnail: Image.network(
                'https://static.wwnd.space' + model.poster.url,
              ),
              title: model.names.ru,
              subtitle: model.description,
            ),
          ),
        );
      },
      // separatorBuilder: (context, index) => Divider(),
      controller: scrollController,
    );
  }
}
