import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/providers.dart';
import 'package:flutter/widgets.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updatesFeedPageControllerProvider = ChangeNotifierProvider(
  (ref) => UpdatesFeedPageController(ref),
);

class UpdatesFeedPageController extends flutter.ChangeNotifier {
  final Ref _ref;
  AsyncValue<List<Title>> titles;
  bool isLoadingMore = false;

  UpdatesFeedPageController(this._ref) : titles = const AsyncValue.loading() {
    fetch();
  }

  Future<void> fetch() async {
    titles = await AsyncValue.guard(
      () async {
        final updates = await _ref.read(anilibriaProvider).getUpdates(
            limit: 15,
            filter: [
              'id',
              'names',
              'description',
              'poster',
              'player.series.string',
            ],
            descriptionType: DescriptionType.plain);
        return updates.toList();
      },
    );
    notifyListeners();
  }

  Future<void> fetchMore() async {
    final resp = await _ref.read(anilibriaProvider).getUpdates(
      filter: [
        'names',
        'description',
        'poster',
        'player.series.string',
      ],
      limit: 15,
      after: titles.value?.length ?? 0,
      descriptionType: DescriptionType.plain,
    );
    titles.value!.addAll(resp);
    notifyListeners();
  }
}
