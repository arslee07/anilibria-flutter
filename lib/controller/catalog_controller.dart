import 'package:anilibria/model/title_model.dart';
import 'package:anilibria/provider/anilibria_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogController extends GetxController
    with StateMixin<List<TitleModel>> {
  final provider = Get.find<AnilibriaApi>();

  ScrollController scrollController = ScrollController();

  void _handleScroll() {
    var triggerFetchMoreSize = 0.9 * scrollController.position.maxScrollExtent;

    if (scrollController.position.pixels > triggerFetchMoreSize) {
      print('balls');
      loadMore();
    }
  }

  Future<void> fetchList() async {
    final Response res = await provider.getUpdates();
    print(res.body);
    // print(res.body[0].description);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
    } else {
      change(res.body, status: RxStatus.success());
    }
  }

  Future<void> loadMore() async {
    change(state, status: RxStatus.loadingMore());
    final Response res = await provider.getUpdates(after: state!.length);
    if (!res.hasError) {
      change([...?state, ...res.body], status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    fetchList();
    scrollController.addListener(_handleScroll);
    super.onInit();
  }
}
