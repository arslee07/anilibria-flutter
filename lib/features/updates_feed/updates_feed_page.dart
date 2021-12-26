import 'package:anilibria_app/features/updates_feed/updates_feed_page_controller.dart';
import 'package:anilibria_app/features/updates_feed/components/title_item.dart';
import 'package:anilibria_app/utils/always_disabled_focus_node.dart';
import 'package:anilibria_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:transparent_image/transparent_image.dart';

class UpdatesFeedPage extends HookConsumerWidget {
  const UpdatesFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(body: UpdatesFeedBody());
  }
}

class UpdatesFeedBody extends ConsumerWidget {
  const UpdatesFeedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedController = ref.watch(updatesFeedPageControllerProvider);
    final scrollController = feedController.scrollController;
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 200) {
        if (!feedController.isLoadingMore) {
          feedController.isLoadingMore = true;
          feedController
              .fetchMore()
              .catchError((err, stack) => print(stack))
              .whenComplete(() => feedController.isLoadingMore = false);
        }
      }
    });

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: TextField(
            onTap: () => Routemaster.of(context).push('/titles/search'),
            decoration: const InputDecoration(
              icon: Icon(Icons.search),
              hintText: 'Поиск по навзанию...',
              border: InputBorder.none,
            ),
            focusNode: AlwaysDisabledFocusNode(),
            enableInteractiveSelection: false,
            mouseCursor: SystemMouseCursors.click,
            readOnly: true,
          ),
          forceElevated: true,
          floating: true,
          snap: true,
        ),
        feedController.titles.when(
          data: (data) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
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

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: InkWell(
                    onTap: model.id == null
                        ? null
                        : () =>
                            Routemaster.of(context).push('/titles/${model.id}'),
                    child: TitleItem(
                      thumbnail: Hero(
                        tag: model.id!,
                        child: FadeInImage.memoryNetwork(
                          image: kStaticUrl.toString() + (poster?.url ?? ''),
                          placeholder: kTransparentImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: title,
                      subtitle: model.description ?? '',
                    ),
                  ),
                );
              },
              childCount: data.length + 1,
            ),
          ),
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, stack) => SliverFillRemaining(
            child: Center(child: Text(err.toString())),
          ),
        )
      ],
    );
  }
}
