import 'package:anilibria_app/utils/config.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

final playerControllerProvider =
    ChangeNotifierProvider.family.autoDispose<PlayerController, String>(
  (ref, url) {
    final c = PlayerController(ref, url);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    ref.onDispose(
      () {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
        c.dispose();
        c.playerController.dispose();
      },
    );
    return c;
  },
);

class PlayerController extends flutter.ChangeNotifier {
  final Ref _ref;
  final VideoPlayerController playerController;

  PlayerController(this._ref, String url)
      : playerController =
            VideoPlayerController.network(kVideosUrl.toString() + url) {
    playerController.addListener(() => notifyListeners());
    playerController.initialize().then((_) => playerController.play());
  }
}
