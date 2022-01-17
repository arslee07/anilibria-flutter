import 'package:anilibria_app/utils/config.dart';
import 'package:anilibria_app/utils/widgets/auto_hide.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

final playerControllerProvider =
    ChangeNotifierProvider.family.autoDispose<PlayerController, String>(
  (ref, url) {
    final c = PlayerController(ref, url);
    c.init();
    ref.onDispose(c.dispose);
    return c;
  },
);

class PlayerController extends flutter.ChangeNotifier {
  final Ref _ref;

  final VideoPlayerController playerController;
  final AutoHideController hideController;

  PlayerController(this._ref, String url)
      : playerController = VideoPlayerController.network(
          kVideosUrl.toString() + url,
        ),
        hideController = AutoHideController(
          duration: const Duration(seconds: 5),
        );

  void init() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    playerController.addListener(() => notifyListeners());
    playerController.initialize().then((_) => playerController.play());
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    hideController.dispose();
    playerController.dispose();
    super.dispose();
  }

  void seekTo(Duration position) {
    playerController.seekTo(position);
  }

  Future<void> back() async {
    playerController.seekTo(
      (await playerController.position ?? Duration.zero) -
          const Duration(seconds: 10),
    );
  }

  Future<void> forward() async {
    playerController.seekTo(
      (await playerController.position ?? Duration.zero) +
          const Duration(seconds: 10),
    );
  }
}
