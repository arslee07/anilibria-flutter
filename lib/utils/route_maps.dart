import 'package:anilibria_app/features/home/home_page.dart';
import 'package:anilibria_app/features/player/player_page.dart';
import 'package:anilibria_app/features/title_info/title_info_page.dart';
import 'package:anilibria_app/features/titles_search/titles_search_screen.dart';
import 'package:anilibria_app/utils/keys.dart';
import 'package:anilibria_app/utils/player_title_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterProvider = Provider(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => '/releases',
      ),
      GoRoute(
        path: '/youtube',
        pageBuilder: (_, __) => MaterialPage(child: HomePage(key: homeKey)),
      ),
      GoRoute(
        path: '/releases',
        pageBuilder: (_, __) => MaterialPage(child: HomePage(key: homeKey)),
        routes: [
          GoRoute(
            path: 'search',
            pageBuilder: (_, __) => CustomTransitionPage(
              child: const TitlesSearchPage(),
              transitionsBuilder: (_, animation, __, child) =>
                  FadeTransition(opacity: animation, child: child),
              transitionDuration: const Duration(milliseconds: 150),
            ),
          ),
          GoRoute(
            path: r':id(\d+)',
            pageBuilder: (_, state) => MaterialPage(
              child: TitleInfoPage(int.parse(state.params['id']!)),
            ),
            routes: [
              GoRoute(
                path: 'player',
                redirect: (_, s) =>
                    s.extra == null ? '/releases/${s.params["id"]!}' : null,
                pageBuilder: (_, state) => MaterialPage(
                  child: PlayerPage(state.extra! as PlayerTitleInfo),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
);
