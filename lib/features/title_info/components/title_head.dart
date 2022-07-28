import 'package:anilibria/anilibria.dart' as anilibria;
import 'package:anilibria_app/utils/config.dart';
import 'package:anilibria_app/utils/widgets/blank_space.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:transparent_image/transparent_image.dart';

class TitleHead extends StatelessWidget {
  final anilibria.Title model;
  const TitleHead(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: ResponsiveValue(
            context,
            defaultValue: 550 / 3.75,
            valueWhen: const [
              Condition.largerThan(name: MOBILE, value: 550 / 3.5),
              Condition.largerThan(name: TABLET, value: 550 / 3),
            ],
          ).value,
          child: AspectRatio(
            aspectRatio: 7.0 / 10.0,
            child: Hero(
              tag: model.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Container(color: Colors.black12),
                    FadeInImage.memoryNetwork(
                      image: kStaticUrl.toString() +
                          (model.posters?.original?.url ?? ''),
                      placeholder: kTransparentImage,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        BlankSpace.right(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.names!.ru ??
                    model.names!.alternative ??
                    model.names!.en ??
                    '[Без навзвания]',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 20),
              ),
              BlankSpace.bottom(2),
              if (model.names!.en != null)
                Text(
                  model.names!.en!,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 15),
                ),
              BlankSpace.bottom(2),
              ActionChip(
                avatar: const Icon(Icons.star_border, size: 18),
                label: Text(
                  (model.inFavorites ?? 0).toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                backgroundColor: Colors.transparent,
                onPressed: () {},
                shape: const StadiumBorder(side: BorderSide(width: 0.2)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
