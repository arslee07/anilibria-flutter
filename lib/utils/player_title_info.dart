import 'package:anilibria/anilibria.dart';

class PlayerTitleInfo {
  final Skips? skips;
  final String url;
  final String titleName;
  final int serieNumber;

  PlayerTitleInfo(this.url, this.titleName, this.serieNumber, this.skips);
}
