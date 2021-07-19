import 'package:anilibria/controller/search_controller.dart';
import 'package:anilibria/ui/title/title_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleSearchDelegate extends SearchDelegate {
  final SearchController controller = Get.find<SearchController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return controller.obx(
        (state) => ListView.builder(
            itemCount: state!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state[index].names.ru),
              );
            }),
        onLoading: Center(
          child: CircularProgressIndicator(),
        ),
        onEmpty: Center(
          child: Text('Не найдено =('),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != controller.query.value) {
      controller.query.value = query;
      controller.fetchList();
    }
    return controller.obx(
      (state) => ListView.builder(
          itemCount: state!.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => Get.to(() => TitlePage(model: state[index])),
              title: Text(state[index].names.ru),
              contentPadding: EdgeInsets.all(8.0),
              leading: Image.network(
                'https://static.wwnd.space' + state[index].poster.url,
              ),
            );
          }),
      onError: (status) {
        if (status == 'not-found') {
          return Center(
            child: Text('Не найдено =('),
          );
        } else {
          return Center(
            child: Text('какаята ошибкка произомшл\n\n$status'),
          );
        }
      },
      onLoading: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
