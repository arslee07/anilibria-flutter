import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

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
              Text(
                title,
                maxLines: 4,
                // overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Expanded(
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
                  style: const TextStyle(fontSize: 14),
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
  const TitleItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: SizedBox(
        height: ResponsiveValue(
          context,
          defaultValue: 550 / 4,
          valueWhen: const [
            Condition.largerThan(name: MOBILE, value: 550 / 3.5),
            Condition.largerThan(name: TABLET, value: 550 / 3),
            Condition.largerThan(name: DESKTOP, value: 550 / 2),
          ],
        ).value,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 7.0 / 10.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: thumbnail,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _TitleDescription(
                  title: title,
                  subtitle: subtitle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
