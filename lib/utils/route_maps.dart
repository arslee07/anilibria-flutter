import 'package:anilibria_app/features/updates_feed/ui/updates_feed_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final routeMap = RouteMap(
  onUnknownRoute: (_) => const Redirect('/'),
  routes: {
    '/': (_) => const MaterialPage(child: UpdatesFeedPage()),
  },
);