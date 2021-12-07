import 'package:anilibria_app/features/title_info/title_info_page.dart';
import 'package:anilibria_app/features/updates_feed/updates_feed_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final routeMap = RouteMap(
  onUnknownRoute: (_) => const Redirect('/'),
  routes: {
    '/': (_) => const MaterialPage(child: UpdatesFeedPage()),
    '/titles/:id': (_) =>
        MaterialPage(child: TitleInfoPage(int.parse(_.pathParameters['id']!))),
  },
);
