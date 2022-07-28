import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Widget? child;

  const Section({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: child,
    );
  }
}
