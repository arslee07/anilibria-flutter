import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final titleInfoPageControllerProvider =
    ChangeNotifierProvider((ref) => TitleInfoPageController(ref));

class TitleInfoPageController extends ChangeNotifier {
  final Ref _ref;

  TitleInfoPageController(this._ref);
}
