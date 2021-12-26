import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/providers.dart';
import 'package:flutter/widgets.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
