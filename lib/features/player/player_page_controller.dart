import 'package:anilibria_app/utils/config.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

final playerPageControllerProvider =
    ChangeNotifierProvider.family.autoDispose<ChewieController, String>(
  (ref, url) {
    final c = ChewieController(
      videoPlayerController: VideoPlayerController.network(
        kVideosUrl.toString() + url,
      ),
      autoInitialize: true,
      autoPlay: true,
      useRootNavigator: false,
      allowedScreenSleep: false,
      showControlsOnInitialize: false,
      allowMuting: false,
      full
      placeholder: const Center(child: CircularProgressIndicator()),
      overlay: const Center(child: CircularProgressIndicator()),
      systemOverlaysOnEnterFullScreen: [],
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
      aspectRatio: 16 / 9,
    );
    ref.onDispose(() {
      c.videoPlayerController.dispose();
      c.dispose();
    });
    return c;
  },
);
