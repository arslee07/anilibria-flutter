import 'package:flutter/material.dart';

class TitleInfoPage extends StatelessWidget {
  final int id;
  const TitleInfoPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(id.toString())),
    );
  }
}
