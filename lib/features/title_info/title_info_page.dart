import 'package:anilibria_app/features/title_info/components/title_description.dart';
import 'package:anilibria_app/features/title_info/components/title_head.dart';
import 'package:anilibria_app/features/title_info/components/title_info.dart';
import 'package:anilibria_app/features/title_info/components/title_series.dart';
import 'package:anilibria_app/features/title_info/title_info_page_controller.dart';
import 'package:anilibria_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:transparent_image/transparent_image.dart';

class TitleInfoPage extends HookConsumerWidget {
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
                      placeholder: kTransparentImage,
                      image: kStaticUrl.toString() + (data.poster?.url ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TitleHead(data),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TitleInfo(data),
                ),
              ),
              if (data.description != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TitleDescription(data.description!),
                  ),
                ),
              if (data.player != null)
                SliverPadding(
                  padding: const EdgeInsets.all(2),
                  sliver: TitleSeries(data),
                ),
              const SliverFillRemaining(),
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
