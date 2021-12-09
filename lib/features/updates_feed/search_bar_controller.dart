import 'dart:async';

import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/providers.dart';
import 'package:flutter/widgets.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchBarControllerProvier = ChangeNotifierProvider((ref) {
  final c = SearchBarController(ref);
  ref.onDispose(() => c.scrollController.dispose());
  return c;
});

class SearchBarController extends flutter.ChangeNotifier {
  final Ref _ref;
  AsyncValue<List<Title>> titles;
  flutter.ScrollController scrollController;

  SearchBarController(this._ref)
      : titles = const AsyncValue.data([]),
        scrollController = flutter.ScrollController();

  void onSearchChanged(String query) {
    fetch(query);
  }

  Future<void> fetch(String query) async {
    titles = const AsyncValue.loading();
    titles = await AsyncValue.guard(() async {
      return (await _ref
              .read(anilibriaProvider)
              .searchTitles(search: query, limit: 10))
          .toList();
    });
    notifyListeners();
  }
}
