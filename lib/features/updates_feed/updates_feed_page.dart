import 'package:anilibria_app/features/updates_feed/components/updates_list.dart';
import 'package:anilibria_app/features/updates_feed/updates_feed_page_controller.dart';
import 'package:anilibria_app/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UpdatesFeedPage extends ConsumerWidget {
  const UpdatesFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedController = ref.watch(updatesFeedPageControllerProvider);
    final scrollController = feedController.scrollController;

    return Scaffold(
      appBar: AppBar(title: const Text('AniLibira'), actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => context.push('/titles/search'),
          tooltip: 'Поиск по названию',
        ),
        PopupMenuButton(
          tooltip: 'Меню',
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              onTap: () {
                ref.read(anilibriaProvider).getRandomTitle(filter: ['id']).then(
                  (v) => context.push('/titles/${v.id!}'),
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
    );
  }
}
