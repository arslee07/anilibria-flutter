import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final anilibriaProvider = Provider((ref) => Anilibria(kApiUrl));
