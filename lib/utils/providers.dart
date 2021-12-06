import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/config.dart';
import 'package:anilibria_app/utils/route_maps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

final anilibriaProvider = Provider((ref) => Anilibria(kApiUrl));

final routeMapProvider = Provider((ref) => routeMap);
final routerParserProvider = Provider((ref) => const RoutemasterParser());
final routerDelegateProvider = Provider(
  (ref) => RoutemasterDelegate(
    routesBuilder: (context) => ref.watch(routeMapProvider),
  ),
);
