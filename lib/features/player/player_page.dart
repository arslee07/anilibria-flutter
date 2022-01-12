import 'package:anilibria_app/features/player/player_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends ConsumerWidget {
  final String url;
  const PlayerPage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(playerControllerProvider(url));
    print(controller.playerController.value);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          VideoPlayer(controller.playerController),
          InkWell(
            onTap: controller.playerController.value.isPlaying
                ? controller.playerController.pause
                : controller.playerController.play,
          ),
        ],
      ),
    );
  }
}
