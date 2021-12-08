import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/widgets.dart' as flutter;

final titleInfoPageControllerProvider =
    ChangeNotifierProvider.family<TitleInfoPageController, int>(
  (ref, id) => TitleInfoPageController(ref, id),
);

class TitleInfoPageController extends flutter.ChangeNotifier {
  final Ref _ref;
  final int id;

  AsyncValue<Title> title;

  TitleInfoPageController(this._ref, this.id)
      : title = const AsyncValue.loading() {
    fetch();
  }

  Future<void> fetch() async {
    title = await AsyncValue.guard(
      () => _ref.read(anilibriaProvider).getTitle(id: id),
    );
    notifyListeners();
  }
}
