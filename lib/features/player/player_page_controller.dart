import 'package:anilibria_app/utils/config.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerPageControllerProvider =
    Provider.family.autoDispose<BetterPlayerController, String>(
  (ref, url) {
    final c = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoDetectFullscreenDeviceOrientation: true,
        autoDetectFullscreenAspectRatio: true,
        controlsConfiguration:
            BetterPlayerControlsConfiguration(enableMute: false),
        allowedScreenSleep: false,
        autoPlay: true,
        expandToFill: true,
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(
        kVideosUrl.toString() + url,
      ),
    );
    return c;
  },
);
