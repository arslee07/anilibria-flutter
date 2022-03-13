import 'package:anilibria_app/features/youtube_feed/components/youtube_item.dart';
import 'package:anilibria_app/features/youtube_feed/youtube_feed_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YoutubeFeedPage extends ConsumerWidget {
  const YoutubeFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedController = ref.watch(youtubeFeedPageControllerProvider);
    final scrollController = feedController.scrollController;

    return Scaffold(
      appBar: AppBar(title: const Text('YouTube')),
      body: RefreshIndicator(
        onRefresh: feedController.fetch,
        child: feedController.videos.when(
          data: (data) => ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index >= data.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return YoutubeItem(video: data[index]);
            },
            itemCount: data.length + 1,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text(err.toString())),
        ),
      ),
      floatingActionButton: feedController.showJump
          ? FloatingActionButton.small(
              onPressed: () => scrollController.animateTo(
                0,
                curve: Curves.easeOutCubic,
                duration: const Duration(seconds: 1),
              ),
              child: const Icon(Icons.arrow_upward),
              tooltip: 'Вернуться наверх',
            )
          : null,
    );
  }
}
