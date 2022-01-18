import 'package:anilibria_app/features/player/player_page_controller.dart';
import 'package:anilibria_app/utils/player_title_info.dart';
import 'package:anilibria_app/utils/widgets/auto_hide.dart';
import 'package:anilibria_app/utils/widgets/blank_space.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends ConsumerWidget {
  final PlayerTitleInfo info;
  const PlayerPage(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(playerControllerProvider(info.url));

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
            if (controller.playerController.value.isBuffering)
              const Align(child: CircularProgressIndicator()),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: controller.hideController.toggle,
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
            MouseRegion(
              onHover: (_) => controller.hideController.show(),
            ),
            AutoHide(
              switchDuration: const Duration(milliseconds: 250),
              controller: controller.hideController,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                            children: const [
                              BackButton(
                                color: Colors.white,
                              ),
                            ],
                          ),
                          BlankSpace.right(8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  info.titleName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                BlankSpace.bottom(4),
                                Text(
                                  'Серия ${info.serieNumber}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          color: Colors.white,
                          iconSize: 36,
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
                          iconSize: 36,
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
                        thumbRadius: 8,
                        timeLabelTextStyle:
                            const TextStyle(color: Colors.white),
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
