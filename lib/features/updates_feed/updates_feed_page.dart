import 'package:anilibria_app/features/updates_feed/updates_feed_page_controller.dart';
import 'package:anilibria_app/features/updates_feed/components/title_item.dart';
import 'package:anilibria_app/utils/config.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class UpdatesFeedPage extends HookConsumerWidget {
  const UpdatesFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final controller = ref.watch(updatesFeedPageControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AniLibria'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: controller.titles.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          scrollController.addListener(() {
            if (scrollController.position.extentAfter < 200) {
              if (!controller.isLoadingMore) {
                controller.isLoadingMore = true;
                controller
                    .fetchMore()
                    .catchError((err, stack) => print(stack))
                    .whenComplete(() => controller.isLoadingMore = false);
              }
            }
          });

          return ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index >= data.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final model = data[index];
              final names = model.names;
              final poster = model.poster;
              final series = model.player?.series?.string;
              final title = (names?.ru ??
                      names?.alternative ??
                      names?.en ??
                      '[Без навзвания]') +
                  (series == null || series == '1-1' ? '' : ' ($series)');

              return InkWell(
                onTap: model.id == null
                    ? null
                    : () {
                        Routemaster.of(context).push('/titles/${model.id}');
                      },
                child: TitleItem(
                  thumbnail: FancyShimmerImage(
                    imageUrl: kStaticUrl.toString() + (poster?.url ?? ''),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  title: title,
                  subtitle: model.description ?? '',
                ),
              );
            },
            itemCount: data.length + 1,
          );
        },
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }
}
