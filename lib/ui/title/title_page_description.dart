import 'package:anilibria/model/title_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class TitlePageDescription extends StatelessWidget {
  const TitlePageDescription({
    Key? key,
    required this.model,
  }) : super(key: key);

  final TitleModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpandableText(
        model.description,
        expandText: 'Раскрыть',
        collapseText: 'Скрыть',
        maxLines: 10,
      ),
    );
  }
}
