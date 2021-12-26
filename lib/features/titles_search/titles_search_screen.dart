import 'package:anilibria_app/features/titles_search/titles_search_controller.dart';
import 'package:anilibria_app/features/titles_search/components/search_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitlesSearchPage extends ConsumerWidget {
  const TitlesSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(titlesSearchControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: controller.onSearchChanged,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: 'Поиск по названию...',
          ),
        ),
      ),
      body: controller.titles.when(
          data: (data) => ListView.builder(
                itemBuilder: (context, index) =>
                    data.isEmpty ? Container() : SearchTile(data[index]),
                itemCount: data.length,
              ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text(err.toString()))),
    );
  }
}
