import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Expanded(
                child: Text(
                  subtitle,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Get.isDarkMode ? Colors.white54 : Colors.black54,
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
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: SizedBox(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 7.0 / 10.0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), child: thumbnail),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
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
