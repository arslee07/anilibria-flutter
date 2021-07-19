import 'package:anilibria/model/title_model.dart';
import 'package:anilibria/provider/anilibria_api.dart';
import 'package:get/get.dart';

class SearchController extends GetxController
    with StateMixin<List<TitleModel>> {
  final provider = Get.find<AnilibriaApi>();
  final query = ''.obs;

  Future<void> fetchList() async {
    if (query().trim() == '') {
      change(null, status: RxStatus.empty());
    } else {
      change(null, status: RxStatus.loading());
      final Response res = await provider.searchTitles(search: query());
      if (res.hasError) {
        change(null, status: RxStatus.error(res.statusText));
      } else if (res.body.length == 0) {
        change(null, status: RxStatus.error('not-found'));
      } else {
        change(res.body, status: RxStatus.success());
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
