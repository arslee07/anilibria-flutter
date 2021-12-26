import 'package:anilibria_app/features/player/player_page.dart';
import 'package:anilibria_app/features/title_info/title_info_page.dart';
import 'package:anilibria_app/features/titles_search/titles_search_screen.dart';
import 'package:anilibria_app/features/updates_feed/updates_feed_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterProvider = Provider(
  (ref) => GoRouter(routes: [
    GoRoute(
      path: '/',
      redirect: (_) => '/titles',
    ),
    GoRoute(
      path: '/player',
      pageBuilder: (_, state) => MaterialPage(
        child: PlayerPage(state.queryParams['q']!),
      ),
    ),
    GoRoute(
      path: '/titles',
      pageBuilder: (_, __) => const MaterialPage(child: UpdatesFeedPage()),
      routes: [
        GoRoute(
          path: 'search',
          pageBuilder: (_, __) => CustomTransitionPage(
              child: const TitlesSearchPage(),
              transitionsBuilder: (_, animation, __, child) =>
                  FadeTransition(opacity: animation, child: child),
              transitionDuration: const Duration(milliseconds: 150)),
        ),
        GoRoute(
          path: r':id(\d+)',
          pageBuilder: (_, state) => MaterialPage(
            child: TitleInfoPage(int.parse(state.params['id']!)),
          ),
        ),
      ],
    ),
  ]),
);
