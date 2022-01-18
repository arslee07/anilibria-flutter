import 'package:anilibria/anilibria.dart';

String getTitleName(Title title) =>
    title.names?.ru ?? title.names?.en ?? title.names?.alternative ?? '';
