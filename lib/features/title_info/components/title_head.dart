import 'package:anilibria/anilibria.dart' as anilibria;
import 'package:anilibria_app/utils/widgets/blank_space.dart';
import 'package:flutter/material.dart';

class TitleHead extends StatelessWidget {
  final anilibria.Title model;
  const TitleHead(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                model.names!.ru ??
                    model.names!.alternative ??
                    model.names!.en ??
                    '[Без навзвания]',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 20),
              ),
            ),
            BlankSpace.right(8),
            Chip(
              avatar: const Icon(Icons.star_border),
              label: Text((model.inFavorites ?? 0).toString()),
            )
          ],
        ),
        BlankSpace.bottom(4),
        if (model.names!.en != null)
          Text(
            model.names!.en!,
            style:
                Theme.of(context).textTheme.headline5!.copyWith(fontSize: 15),
          ),
      ],
    );
  }
}
