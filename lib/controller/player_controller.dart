import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayerController extends GetxController {
  final String url;
  late final VideoPlayerController videoPlayerController;
  late final ChewieController chewieController;

  PlayerController(this.url);

  @override
  Future<void> onInit() async {
    super.onInit();
    await initializePlayer();
  }

  @override
  void onClose() {
    chewieController.dispose();
    videoPlayerController.dispose();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(url);

    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoInitialize: true,
        autoPlay: true,
        aspectRatio: videoPlayerController.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(handleColor: Colors.red));
  }
}
