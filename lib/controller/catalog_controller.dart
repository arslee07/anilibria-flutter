import 'package:anilibria/model/title_model.dart';
import 'package:anilibria/provider/anilibria_api.dart';
import 'package:get/get.dart';

class CatalogController extends GetxController
    with StateMixin<List<TitleModel>> {
  final provider = Get.find<AnilibriaApi>();

  Future<void> fetchList() async {
    final Response res = await provider.getUpdates();
    print(res.hasError);
    // print(res.body[0].description);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
    } else {
      change(res.body, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    fetchList();
    super.onInit();
  }
}
