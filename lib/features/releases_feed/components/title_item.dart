import 'package:anilibria_app/utils/config.dart';
import 'package:anilibria_app/utils/get_title_name.dart';
import 'package:anilibria_app/utils/widgets/blank_space.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:anilibria/anilibria.dart' as anilibria;
import 'package:transparent_image/transparent_image.dart';

class _TitleDescription extends StatelessWidget {
  const _TitleDescription({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: Text(
                  title,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              BlankSpace.bottom(4),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    subtitle,
                    maxLines: ResponsiveValue(
                      context,
                      defaultValue: 4,
                      valueWhen: const [
                        Condition.largerThan(name: TABLET, value: 8),
                        Condition.largerThan(name: DESKTOP, value: 10),
                      ],
                    ).value,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.caption!.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TitleItem extends StatelessWidget {
  final anilibria.Title title;

  const TitleItem(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      shadowColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: InkWell(
        onTap: title.id == null
            ? null
            : () => context.push('/releases/${title.id}'),
        child: SizedBox(
          height: ResponsiveValue(
            context,
            defaultValue: 550 / 3.75,
            valueWhen: const [
              Condition.largerThan(name: MOBILE, value: 550 / 3.5),
              Condition.largerThan(name: TABLET, value: 550 / 3),
            ],
          ).value,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 7.0 / 10.0,
                child: Hero(
                  tag: title.id!,
                  child: Stack(
                    children: [
                      Container(color: Colors.black12),
                      FadeInImage.memoryNetwork(
                        image: kStaticUrl.toString() +
                            (title.posters?.original?.url ?? ''),
                        placeholder: kTransparentImage,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: _TitleDescription(
                    title: getTitleName(title) +
                        (title.player?.series?.string == null ||
                                title.player?.series?.string == '1-1'
                            ? ''
                            : ' (${title.player?.series?.string})'),
                    subtitle: title.description ?? '',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
