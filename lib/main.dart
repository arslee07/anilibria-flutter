import 'package:anilibria/controller/catalog_controller.dart';
import 'package:anilibria/controller/search_controller.dart';
import 'package:anilibria/provider/anilibria_api.dart';
import 'package:anilibria/ui/catalog/catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
      ),
      // darkTheme: ThemeData(
      //     brightness: Brightness.dark,
      //     primarySwatch: Colors.red,
      //     accentColor: Colors.red),
      title: 'AniLibria',
      initialBinding: BindingsBuilder.put(() => AnilibriaApi()),
      getPages: [
        GetPage(
            name: '/catalog',
            page: () => CatalogPage(),
            binding: BindingsBuilder(() {
              Get.put(CatalogController());
              Get.put(SearchController());
            }))
      ],
      initialRoute: '/catalog',
    );
  }
}
