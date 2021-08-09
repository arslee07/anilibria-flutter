import 'package:anilibria/model/title_model.dart';
import 'package:flutter/material.dart';

class TitlePageAppBar extends StatelessWidget {
  const TitlePageAppBar({
    Key? key,
    required this.model,
  }) : super(key: key);

  final TitleModel model;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 500.0,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return FlexibleSpaceBar(
              title: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                child: Text(
                  model.names.ru,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                opacity: constraints.biggest.height <= 80.0 ? 1.0 : 0.0,
              ),
              background: Image.network(
                'https://static.wwnd.space' + model.poster.url,
                fit: BoxFit.cover,
              ));
        },
      ),
    );
  }
}
