import 'package:anilibria_app/features/updates_feed/updates_feed_page.dart';
import 'package:anilibria_app/features/youtube_feed/youtube_feed_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_icons/simple_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  int _getIndex(String loc) {
    switch (loc) {
      case '/titles':
        return 0;
      case '/youtube':
        return 1;
      default:
        return 0;
    }
  }

  String _getRoute(int index) {
    switch (index) {
      case 0:
        return '/titles';
      case 1:
        return '/youtube';
      default:
        return '/titles';
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = GoRouter.of(context).location;
    return Scaffold(
      body: IndexedStack(
        children: const [UpdatesFeedPage(), YoutubeFeedPage()],
        index: _getIndex(loc),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getIndex(loc),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => context.go(_getRoute(index)),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Обновления',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.youtube),
            label: 'YouTube',
          ),
        ],
      ),
    );
  }
}
