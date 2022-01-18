import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TitleDescription extends StatelessWidget {
  final String description;
  const TitleDescription(this.description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ExpandableText(
          description,
          expandText: 'развернуть',
          collapseText: 'свернуть',
          maxLines: 8,
          animation: true,
          animationDuration: const Duration(milliseconds: 500),
          collapseOnTextTap: !kIsWeb,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
