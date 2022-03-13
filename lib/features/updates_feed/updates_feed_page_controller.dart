import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/providers.dart';
import 'package:flutter/rendering.dart';
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
  bool showJump = false;

  final flutter.ScrollController scrollController;

  UpdatesFeedPageController(this._ref)
      : titles = const AsyncValue.loading(),
        scrollController = flutter.ScrollController() {
    scrollController
      ..addListener(handleLazyLoad)
      ..addListener(handleTopJump);
    fetch();
  }

  void handleLazyLoad() {
    if (scrollController.position.extentAfter < 200) {
      if (!isLoadingMore) {
        isLoadingMore = true;
        fetchMore()
            .catchError((err, stack) => print(stack))
            .whenComplete(() => isLoadingMore = false);
      }
    }
  }

  void handleTopJump() {
    final s = scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        scrollController.position.pixels > 0;

    if (s != showJump) {
      showJump = s;
      notifyListeners();
    }
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
