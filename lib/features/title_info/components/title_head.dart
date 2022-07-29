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
    return ResponsiveValue<Widget>(
      context,
      defaultValue: _buildSmallLayout(context),
      valueWhen: [
        Condition.largerThan(
          name: MOBILE,
          value: _buildLargeLayout(context),
        )
      ],
    ).value!;
  }

  Widget _buildSmallLayout(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 320),
            child: _buildPoster(),
          ),
        ),
        BlankSpace.bottom(16),
        _buildInfo(context, true),
      ],
    );
  }

  Widget _buildLargeLayout(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: ResponsiveValue(
            context,
            defaultValue: 550 / 3.5,
            valueWhen: const [
              Condition.largerThan(name: MOBILE, value: 550 / 3),
              Condition.largerThan(name: TABLET, value: 550 / 2.5),
            ],
          ).value,
          child: _buildPoster(),
        ),
        BlankSpace.right(16),
        Expanded(
          child: _buildInfo(context),
        ),
      ],
    );
  }

  Widget _buildPoster() {
    return AspectRatio(
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
    );
  }

  Widget _buildInfo(BuildContext context, [bool center = false]) {
    final stars = ActionChip(
      avatar: const Icon(Icons.star_border, size: 18),
      label: Text(
        (model.inFavorites ?? 0).toString(),
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: Colors.transparent,
      onPressed: () {},
      shape: const StadiumBorder(side: BorderSide(width: 0.2)),
    );

    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          model.names!.ru ??
              model.names!.alternative ??
              model.names!.en ??
              '[Без навзвания]',
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 20),
          textAlign: center ? TextAlign.center : null,
        ),
        BlankSpace.bottom(4),
        if (model.names!.en != null)
          Text(
            model.names!.en!,
            style:
                Theme.of(context).textTheme.headline5!.copyWith(fontSize: 15),
            textAlign: center ? TextAlign.center : null,
          ),
        BlankSpace.bottom(4),
        center ? Center(child: stars) : stars,
      ],
    );
  }
}
