import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:anilibria_app/features/releases_feed/releases_feed_page.dart';
import 'package:anilibria_app/features/youtube_feed/youtube_feed_page.dart';
import 'package:anilibria_app/utils/widgets/lazy_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static int _getIndex(String loc) {
    if (loc == '/releases') return 0;
    if (loc == '/youtube') return 1;
    return 0;
  }

  static String _getRoute(int index) {
    if (index == 0) return '/releases';
    if (index == 1) return '/youtube';
    return '/releases';
  }

  @override
  Widget build(BuildContext context) {
    final loc = GoRouter.of(context).location;
    return AdaptiveNavigationScaffold(
      body: LazyIndexedStack(
        children: const [ReleasesFeedPage(), YoutubeFeedPage()],
        index: _getIndex(loc),
      ),
      selectedIndex: _getIndex(loc),
      onDestinationSelected: (index) => context.go(_getRoute(index)),
      destinations: const [
        AdaptiveScaffoldDestination(
          icon: Icons.newspaper,
          title: 'Релизы',
        ),
        AdaptiveScaffoldDestination(
          icon: FontAwesomeIcons.youtube,
          title: 'YouTube',
        ),
      ],
    );
  }
}
