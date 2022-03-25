import 'package:anilibria_app/features/releases_feed/components/updates_list.dart';
import 'package:anilibria_app/features/releases_feed/releases_feed_page_controller.dart';
import 'package:anilibria_app/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReleasesFeedPage extends ConsumerWidget {
  const ReleasesFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedController = ref.watch(updatesFeedPageControllerProvider);
    final scrollController = feedController.scrollController;

    return Scaffold(
      appBar: AppBar(title: const Text('AniLibira'), actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => context.push('/releases/search'),
          tooltip: 'Поиск по названию',
        ),
        PopupMenuButton(
          tooltip: 'Меню',
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              onTap: () {
                ref.read(anilibriaProvider).getRandomTitle(filter: ['id']).then(
                  (v) => context.push('/releases/${v.id!}'),
                );
              },
              child: const Text('Случайный релиз'),
            ),
          ],
        ),
      ]),
      body: feedController.titles.when(
        data: (data) => RefreshIndicator(
          onRefresh: feedController.fetch,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              UpdatesList(data),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
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
