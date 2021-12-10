import 'package:anilibria_app/utils/config.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/widgets.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

final playerPageControllerProvider =
    ChangeNotifierProvider.family.autoDispose<PlayerPageController, String>(
  (ref, url) {
    final c = PlayerPageController(url);
    ref.onDispose(() => c.manager.dispose());
    return c;
  },
);

class PlayerPageController extends flutter.ChangeNotifier {
  final FlickManager manager;
  PlayerPageController(String url)
      : manager = FlickManager(
          videoPlayerController: VideoPlayerController.network(
            kVideosUrl.toString() + url,
          ),
        );
}
