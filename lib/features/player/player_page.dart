import 'package:anilibria_app/features/player/player_page_controller.dart';
import 'package:anilibria_app/utils/widgets/auto_hide.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends ConsumerWidget {
  final String url;
  const PlayerPage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(playerControllerProvider(url));

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayer(controller.playerController),
              ),
            ),
            AutoHide(
              switchDuration: const Duration(milliseconds: 250),
              controller: controller.hideController,
              child: Container(color: Colors.black54),
            ),
            GestureDetector(
              onTap: controller.hideController.trigger,
              onDoubleTapDown: (details) {
                print(details.globalPosition.dx);
                if (details.globalPosition.dx <
                    MediaQuery.of(context).size.width) {
                  controller.back();
                } else {
                  controller.forward();
                }
              },
            ),
            AutoHide(
              switchDuration: const Duration(milliseconds: 250),
              controller: controller.hideController,
              child: Stack(
                children: [
                  Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          color: Colors.white,
                          iconSize: 48,
                          icon: const Icon(Icons.replay_10),
                          onPressed: controller.back,
                        ),
                        IconButton(
                          color: Colors.white,
                          iconSize: 48,
                          icon: Icon(
                            controller.playerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: controller.playerController.value.isPlaying
                              ? controller.playerController.pause
                              : controller.playerController.play,
                        ),
                        IconButton(
                          color: Colors.white,
                          iconSize: 48,
                          icon: const Icon(Icons.forward_10),
                          onPressed: controller.forward,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: ProgressBar(
                        progress: controller.playerController.value.position,
                        total: controller.playerController.value.duration,
                        buffered: controller
                                .playerController.value.buffered.isNotEmpty
                            ? controller
                                .playerController.value.buffered.last.end
                            : null,
                        timeLabelPadding: 4,
                        onSeek: controller.seekTo,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
