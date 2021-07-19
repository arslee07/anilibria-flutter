import 'package:anilibria/controller/catalog_controller.dart';
import 'package:get/get.dart';

class CatalogBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CatalogController>(() => CatalogController());
  }
}
