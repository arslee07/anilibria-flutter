import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/providers.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final youtubeFeedPageControllerProvider = ChangeNotifierProvider(
  (ref) {
    final c = YoutubeFeedPageController(ref);
    ref.onDispose(() => c.scrollController.dispose());
    return c;
  },
);

class YoutubeFeedPageController extends flutter.ChangeNotifier {
  final Ref _ref;
  AsyncValue<List<Youtube>> videos;
  bool isLoadingMore = false;
  bool showJump = false;

  final flutter.ScrollController scrollController;

  YoutubeFeedPageController(this._ref)
      : videos = const AsyncValue.loading(),
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
    final s = scrollController.position.pixels > 140;

    if (s != showJump) {
      showJump = s;
      notifyListeners();
    }
  }

  Future<void> fetch() async {
    videos = await AsyncValue.guard(
      () async {
        final updates =
            await _ref.read(anilibriaProvider).getYoutube(limit: 15);
        return updates.toList();
      },
    );
    notifyListeners();
  }

  Future<void> fetchMore() async {
    final resp = await _ref
        .read(anilibriaProvider)
        .getYoutube(limit: 15, after: videos.value?.length ?? 0);
    videos.value!.addAll(resp);
    notifyListeners();
  }
}
