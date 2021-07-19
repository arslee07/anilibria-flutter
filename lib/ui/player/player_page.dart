import 'package:anilibria/controller/player_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerPage extends StatelessWidget {
  final String url;
  PlayerPage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GetBuilder<PlayerController>(
          init: PlayerController(url),
          initState: (_) {},
          builder: (_) {
            return _.initialized
                ? Chewie(controller: _.chewieController)
                : CircularProgressIndicator();
          },
        ),
        color: Colors.black,
      ),
    );
  }
}
