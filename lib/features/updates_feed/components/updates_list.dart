import 'package:anilibria_app/features/updates_feed/components/title_item.dart';
import 'package:flutter/material.dart';
import 'package:anilibria/anilibria.dart' as anilibria;

class UpdatesList extends StatelessWidget {
  final List<anilibria.Title> titles;

  const UpdatesList(this.titles, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= titles.length) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final model = titles[index];

          return TitleItem(model);
        },
        childCount: titles.length + 1,
      ),
    );
  }
}
