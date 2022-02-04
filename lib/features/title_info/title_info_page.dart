import 'package:anilibria_app/features/title_info/components/title_description.dart';
import 'package:anilibria_app/features/title_info/components/title_head.dart';
import 'package:anilibria_app/features/title_info/components/title_info.dart';
import 'package:anilibria_app/features/title_info/components/title_serie_tile.dart';
import 'package:anilibria_app/features/title_info/title_info_page_controller.dart';
import 'package:anilibria_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:transparent_image/transparent_image.dart';

class TitleInfoPage extends ConsumerWidget {
  final int id;
  const TitleInfoPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(titleInfoPageControllerProvider(id));

    return Scaffold(
      body: controller.title.when(
        data: (data) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                expandedHeight: 450,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: id,
                    child: FadeInImage.memoryNetwork(
                      image: kStaticUrl.toString() +
                          (data.posters?.original?.url ?? ''),
                      placeholder: kTransparentImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverStack(
                children: [
                  const SliverPositioned.fill(child: Card()),
                  SliverPadding(
                    padding: const EdgeInsets.all(12),
                    sliver: SliverToBoxAdapter(
                      child: TitleHead(data),
                    ),
                  ),
                ],
              ),
              SliverStack(
                children: [
                  const SliverPositioned.fill(child: Card()),
                  SliverPadding(
                    padding: const EdgeInsets.all(12),
                    sliver: SliverToBoxAdapter(
                      child: TitleInfo(data),
                    ),
                  ),
                ],
              ),
              if (data.description != null)
                SliverStack(
                  children: [
                    const SliverPositioned.fill(child: Card()),
                    SliverPadding(
                      padding: const EdgeInsets.all(12),
                      sliver: SliverToBoxAdapter(
                        child: TitleDescription(data.description!),
                      ),
                    ),
                  ],
                ),
              if (data.player != null)
                SliverStack(
                  children: [
                    const SliverPositioned.fill(child: Card()),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final serie =
                              data.player!.playlist!.reversed.elementAt(index);
                          return TitleSerieTile(data, serie);
                        },
                        childCount: data.player!.playlist!.length,
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
        error: (err, stack) => Center(
          child: Text(err.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
