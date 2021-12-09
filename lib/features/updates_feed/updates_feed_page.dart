import 'package:anilibria_app/features/updates_feed/components/search_tile.dart';
import 'package:anilibria_app/features/updates_feed/search_bar_controller.dart';
import 'package:anilibria_app/features/updates_feed/updates_feed_page_controller.dart';
import 'package:anilibria_app/features/updates_feed/components/title_item.dart';
import 'package:anilibria_app/utils/config.dart';
import 'package:anilibria_app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:routemaster/routemaster.dart';
import 'package:transparent_image/transparent_image.dart';

class UpdatesFeedPage extends HookConsumerWidget {
  const UpdatesFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(body: SearchBar(body: UpdatesFeedBody()));
  }
}

class SearchBar extends ConsumerWidget {
  final Widget body;
  const SearchBar({required this.body, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(searchBarControllerProvier);
    return FloatingSearchBar(
      hint: 'Поиск по названию...',
      transitionCurve: Curves.linear,
      implicitDuration: const Duration(milliseconds: 150),
      transitionDuration: const Duration(milliseconds: 150),
      progress: searchController.titles.when(
        data: (_) => null,
        error: (_, __) => null,
        loading: () => true,
      ),
      onQueryChanged: searchController.onSearchChanged,
      debounceDelay: const Duration(milliseconds: 300),
      body: body,
      builder: (BuildContext context, Animation<double> transition) {
        if ((searchController.titles.value ?? []).isEmpty) return Container();
        return Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            children: (searchController.titles.value ?? [])
                .map((e) => SearchTile(e))
                .toList(),
            shrinkWrap: true,
          ),
        );
      },
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
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
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

          return FloatingSearchBarScrollNotifier(
            child: ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                if (index == 0) return BlankSpace.bottom(62);
                if (index - 1 >= data.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                index--;

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
                          placeholder: kTransparentImage,
                          image: kStaticUrl.toString() + (poster?.url ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: title,
                      subtitle: model.description ?? '',
                    ),
                  ),
                );
              },
              itemCount: data.length + 2,
            ),
          );
        },
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }
}
