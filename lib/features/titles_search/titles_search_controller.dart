import 'dart:async';

import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/debouncer.dart';
import 'package:anilibria_app/utils/providers.dart';
import 'package:flutter/widgets.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titlesSearchControllerProvider =
    ChangeNotifierProvider.autoDispose((ref) {
  final c = TitlesSearchController(ref);
  ref.onDispose(() => c.debouncer.dispose());
  return c;
});

class TitlesSearchController extends flutter.ChangeNotifier {
  final Ref _ref;
  final Debouncer debouncer;
  AsyncValue<List<Title>> titles;

  TitlesSearchController(this._ref)
      : titles = const AsyncValue.data([]),
        debouncer = Debouncer(delay: const Duration(milliseconds: 300));

  void onSearchChanged(String query) {
    debouncer.run(() {
      fetch(query);
    });
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
