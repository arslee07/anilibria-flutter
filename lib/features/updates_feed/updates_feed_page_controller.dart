import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/providers.dart';
import 'package:flutter/widgets.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updatesFeedPageControllerProvider = ChangeNotifierProvider(
  (ref) {
    final c = UpdatesFeedPageController(ref);
    ref.onDispose(() => c.scrollController.dispose());
    return c;
  },
);

class UpdatesFeedPageController extends flutter.ChangeNotifier {
  final Ref _ref;
  AsyncValue<List<Title>> titles;
  bool isLoadingMore = false;

  final flutter.ScrollController scrollController;

  UpdatesFeedPageController(this._ref)
      : titles = const AsyncValue.loading(),
        scrollController = flutter.ScrollController() {
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
              'posters',
              'player.series.string',
            ],
            descriptionType: DescriptionType.noViewOrder);
        return updates.toList();
      },
    );
    notifyListeners();
  }

  Future<void> fetchMore() async {
    final resp = await _ref.read(anilibriaProvider).getUpdates(
      filter: [
        'id',
        'names',
        'description',
        'posters',
        'player.series.string',
      ],
      limit: 15,
      after: titles.value?.length ?? 0,
      descriptionType: DescriptionType.noViewOrder,
    );
    titles.value!.addAll(resp);
    notifyListeners();
  }
}
