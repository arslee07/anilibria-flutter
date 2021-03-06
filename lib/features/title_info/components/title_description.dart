import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TitleDescription extends StatelessWidget {
  final String description;
  const TitleDescription(this.description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      description,
      expandText: 'развернуть',
      collapseText: 'свернуть',
      maxLines: 8,
      animation: true,
      animationDuration: const Duration(milliseconds: 500),
      collapseOnTextTap: !kIsWeb,
      linkStyle: const TextStyle(fontWeight: FontWeight.bold),
      style: Theme.of(context).textTheme.bodyText2,
    );
  }
}
