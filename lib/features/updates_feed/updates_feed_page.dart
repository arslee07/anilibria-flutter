import 'package:anilibria_app/features/updates_feed/updates_feed_page_controller.dart';
import 'package:anilibria_app/features/updates_feed/components/title_item.dart';
import 'package:anilibria_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:transparent_image/transparent_image.dart';

class UpdatesFeedPage extends ConsumerWidget {
  const UpdatesFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('AniLibira'), actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => context.push('/titles/search'),
          tooltip: 'Поиск по названию',
        ),
      ]),
      body: Column(
        children: const [
          Expanded(child: UpdatesFeedBody()),
        ],
      ),
    );
  }
}

class UpdatesFeedBody extends ConsumerWidget {
  const UpdatesFeedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedController = ref.watch(updatesFeedPageControllerProvider);
    final scrollController = feedController.scrollController;

    return RefreshIndicator(
      onRefresh: feedController.fetch,
      child: feedController.titles.when(
        data: (data) => ListView.builder(
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
            final poster = model.posters?.original;
            final series = model.player?.series?.string;
            final title = (names?.ru ??
                    names?.alternative ??
                    names?.en ??
                    '[Без навзвания]') +
                (series == null || series == '1-1' ? '' : ' ($series)');

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: InkWell(
                onTap: model.id == null
                    ? null
                    : () => context.push('/titles/${model.id}'),
                child: TitleItem(
                  thumbnail: Hero(
                    tag: model.id!,
                    child: Stack(
                      children: [
                        Container(color: Colors.black12),
                        FadeInImage.memoryNetwork(
                          image: kStaticUrl.toString() + (poster?.url ?? ''),
                          placeholder: kTransparentImage,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  title: title,
                  subtitle: model.description ?? '',
                ),
              ),
            );
          },
          itemCount: data.length + 1,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }
}
