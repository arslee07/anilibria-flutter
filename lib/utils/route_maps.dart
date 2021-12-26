import 'package:anilibria_app/features/player/player_page.dart';
import 'package:anilibria_app/features/title_info/title_info_page.dart';
import 'package:anilibria_app/features/titles_search/titles_search_screen.dart';
import 'package:anilibria_app/features/updates_feed/updates_feed_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final routeMap = RouteMap(
  onUnknownRoute: (_) => const Redirect('/'),
  routes: {
    '/': (_) => const Redirect('/titles'),
    '/titles': (_) => const MaterialPage(child: UpdatesFeedPage()),
    '/titles/:id': (_) =>
        MaterialPage(child: TitleInfoPage(int.parse(_.pathParameters['id']!))),
    '/titles/search': (_) => const TransitionPage(
        child: TitlesSearchPage(),
        pushTransition: PageTransition.zoom,
        popTransition: PageTransition.zoom),
    '/player': (_) => _.queryParameters['q'] == null
        ? const Redirect('/')
        : MaterialPage(
            child: PlayerPage(_.queryParameters['q']!),
            maintainState: false,
          ),
  },
);
