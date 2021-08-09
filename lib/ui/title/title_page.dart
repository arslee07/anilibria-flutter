import 'package:anilibria/model/title_model.dart';
import 'package:anilibria/ui/player/player_page.dart';
import 'package:anilibria/ui/title/title_page_app_bar.dart';
import 'package:anilibria/ui/title/title_page_description.dart';
import 'package:anilibria/ui/title/title_page_genres.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitlePage extends StatelessWidget {
  final TitleModel model;
  const TitlePage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [TitlePageAppBar(model: model)],
        body: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitlePageDescription(model: model),
                Divider(),
                Padding(padding: EdgeInsets.only(bottom: 8)),
                TitlePageGenres(model: model),
                Padding(padding: EdgeInsets.only(bottom: 8)),
                Divider(),
                ElevatedButton(
                    onPressed: () => Get.to(
                          () => PlayerPage(
                            'https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8',
                          ),
                        ),
                    child: Text('play smth'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
