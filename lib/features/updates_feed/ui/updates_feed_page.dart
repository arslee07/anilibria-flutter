import 'package:anilibria_app/features/updates_feed/controllers/updates_feed_page_controller.dart';
import 'package:anilibria_app/features/updates_feed/ui/components/title_item.dart';
import 'package:anilibria_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdatesFeedPage extends HookConsumerWidget {
  const UpdatesFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(updatesFeedPageControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AniLibria'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: controller.titles.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (data) {
          final scroll = useScrollController();
          scroll.addListener(() {
            if (scroll.position.extentAfter < 200) {
              if (!controller.isLoadingMore) {
                controller.isLoadingMore = true;
                controller
                    .fetchMore()
                    .catchError((err, stack) => print(stack))
                    .whenComplete(() => controller.isLoadingMore = false);
              }
            }
          });
          return RefreshIndicator(
            onRefresh: () => controller.fetch(),
            child: ListView.builder(
              controller: scroll,
              itemBuilder: (context, index) {
                if (index >= data.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final model = data[index];
                return TitleItem(
                  thumbnail: Image(
                    image: NetworkImage(
                      kStaticUrl.toString() + data[index].poster!.url!,
                    ),
                  ),
                  title: model.names != null
                      ? model.names!.ru ??
                          model.names!.alternative ??
                          model.names!.en ??
                          '[Без навзвания]'
                      : '[Без названия]',
                  subtitle: data[index].description ?? '',
                );
              },
              itemCount: data.length + 1,
            ),
          );
        },
        error: (err, stack) => Center(
          child: Text(err.toString()),
        ),
      ),
    );
  }
}
