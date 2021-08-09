// просто небольшой файлик для перевода из жсона в объектик =)

class TitleModel {
  late final int id;
  late final String code;
  late final NamesModel names;
  late final String announce;
  late final StatusModel status;
  late final PosterModel poster;
  late final int updated;
  late final int lastChange;
  late final TypeModel type;
  late final List<String> genres;
  late final TeamModel team;
  late final SeasonModel season;
  late final String description;
  late final int inFavorites;
  late final BlockedModel blocked;
  late final PlayerModel player;
  late final TorrentsModel torrents;

  TitleModel({
    required this.id,
    required this.code,
    required this.names,
    required this.announce,
    required this.status,
    required this.poster,
    required this.updated,
    required this.lastChange,
    required this.type,
    required this.genres,
    required this.team,
    required this.season,
    required this.description,
    required this.inFavorites,
    required this.blocked,
    required this.player,
    required this.torrents,
  });

  TitleModel.fromJson(Map<String, dynamic> json) {
    print(json['names']['ru']);
    this.id = json['id'];
    this.code = json['code'];
    this.names = NamesModel.fromJson(json['names']);
    this.announce = json['announce'];
    this.status = StatusModel.fromJson(json['status']);
    this.poster = PosterModel.fromJson(json['poster']);
    this.updated = json['updated'];
    this.lastChange = json['last_change'];
    this.type = TypeModel.fromJson(json['type']);
    this.genres = List<String>.from(json['genres']);
    this.team = TeamModel.fromJson(json['team']);
    this.season = SeasonModel.fromJson(json['season']);
    this.description = json['description']
        .replaceAll('\n', ' ')
        .replaceAllMapped(RegExp(r' +'), (_) => ' ');
    this.inFavorites = json['in_favorites'];
    this.blocked = BlockedModel.fromJson(json['blocked']);
    this.player = PlayerModel.fromJson(json['player']);
    this.torrents = TorrentsModel.fromJson(json['torrents']);
  }

  static List<TitleModel> listFromJson(list) =>
      List<TitleModel>.from(list.map((json) => TitleModel.fromJson(json)));
}

class NamesModel {
  late final String ru;
  late final String en;
  late final String alternative;

  NamesModel({
    required this.ru,
    required this.en,
    required this.alternative,
  });

  NamesModel.fromJson(Map<String, dynamic> json) {
    this.ru = json['ru'];
    this.en = json['en'];
    this.alternative = json['alternative'];
  }
}

class StatusModel {
  late final String string;
  late final int code;

  StatusModel({
    required this.string,
    required this.code,
  });

  StatusModel.fromJson(Map<String, dynamic> json) {
    this.string = json['string'];
    this.code = json['code'];
  }
}

class PosterModel {
  late final String url;
  late final int updatedTimestamp;
  late final String rawBase64File;

  PosterModel({
    required this.url,
    required this.updatedTimestamp,
    required this.rawBase64File,
  });

  PosterModel.fromJson(Map<String, dynamic> json) {
    this.url = json['url'];
    this.updatedTimestamp = json['updated_timestamp'];
    this.rawBase64File = json['raw_base64_file'];
  }
}

class TypeModel {
  late final String? fullString = 'aboba';
  late final int code;
  late final String string;
  late final int series;
  late final String length;

  TypeModel({
    required this.fullString,
    required this.code,
    required this.string,
    required this.series,
    required this.length,
  });

  TypeModel.fromJson(Map<String, dynamic> json) {
    print(json);
    this.fullString ??= json['full_string'];
    this.code = json['code'];
    this.string = json['string'];
    this.series = json['series'];
    this.length = json['length'];
  }
}

class TeamModel {
  late final List<String> voice;
  late final List<String> translator;
  late final List<String> editing;
  late final List<String> decor;
  late final List<String> timing;

  TeamModel({
    required this.voice,
    required this.translator,
    required this.editing,
    required this.decor,
    required this.timing,
  });

  TeamModel.fromJson(Map<String, dynamic> json) {
    this.voice = List<String>.from(json['voice']);
    this.translator = List<String>.from(json['translator']);
    this.editing = List<String>.from(json['editing']);
    this.decor = List<String>.from(json['decor']);
    this.timing = List<String>.from(json['timing']);
  }
}

class SeasonModel {
  late final String string;
  late final int code;
  late final int year;
  late final int weekDay;

  SeasonModel({
    required this.string,
    required this.code,
    required this.year,
    required this.weekDay,
  });

  SeasonModel.fromJson(Map<String, dynamic> json) {
    this.string = json['string'];
    this.code = json['code'];
    this.year = json['year'];
    this.weekDay = json['week_day'];
  }
}

class BlockedModel {
  late final bool blocked;
  late final bool wakanim;

  BlockedModel({
    required this.blocked,
    required this.wakanim,
  });

  BlockedModel.fromJson(Map<String, dynamic> json) {
    this.blocked = json['blocked'];
    this.wakanim = json['bakanim'];
  }
}

class PlayerModel {
  late final String alternativePlayer;
  late final String host;
  late final SeriesModel series;
  late final List<SerieModel> playlist;

  PlayerModel({
    required this.alternativePlayer,
    required this.host,
    required this.series,
    required this.playlist,
  });

  PlayerModel.fromJson(Map<String, dynamic> json) {
    this.alternativePlayer = json['alternative_player'];
    this.host = json['host'];
    this.series = SeriesModel.fromJson(json['series']);
    this.playlist = SerieModel.listFromJson(json['playlist']);
  }
}

class SeriesModel {
  late final int first;
  late final int last;
  late final String string;

  SeriesModel({
    required this.first,
    required this.last,
    required this.string,
  });

  SeriesModel.fromJson(Map<String, dynamic> json) {
    this.first = json['first'];
    this.last = json['last'];
    this.string = json['string'];
  }
}

class SerieModel {
  late final int serie;
  late final int createdTimestamp;
  late final HlsModel hls;

  SerieModel({
    required this.serie,
    required this.createdTimestamp,
    required this.hls,
  });

  SerieModel.fromJson(Map<String, dynamic> json) {
    this.serie = json['serie'];
    this.createdTimestamp = json['created_timestamp'];
    this.hls = HlsModel.fromJson(json['hls']);
  }

  static List<SerieModel> listFromJson(list) =>
      List<SerieModel>.from(list.map((json) => SerieModel.fromJson(json)));
}

class HlsModel {
  late final String fhd;
  late final String hd;
  late final String sd;

  HlsModel({
    required this.fhd,
    required this.hd,
    required this.sd,
  });

  HlsModel.fromJson(Map<String, dynamic> json) {
    this.fhd = json['fhd'];
    this.hd = json['hd'];
    this.sd = json['sd'];
  }
}

class TorrentsModel {
  late final SeriesModel series;
  late final List<TorrentModel> list;

  TorrentsModel({
    required this.series,
    required this.list,
  });

  TorrentsModel.fromJson(Map<String, dynamic> json) {
    this.series = SeriesModel.fromJson(json['series']);
    this.list = TorrentModel.listFromJson(json['list']);
  }
}

class TorrentModel {
  late final int torrentId;
  late final SeriesModel series;
  late final QualityModel quality;
  late final int leechers;
  late final int seeders;
  late final int downloads;
  late final int totalSize;
  late final String url;
  late final int uploadedTimestamp;
  late final String metadata;
  late final String rawBase64File;

  TorrentModel({
    required this.torrentId,
    required this.series,
    required this.quality,
    required this.leechers,
    required this.seeders,
    required this.downloads,
    required this.totalSize,
    required this.url,
    required this.uploadedTimestamp,
    required this.metadata,
    required this.rawBase64File,
  });

  TorrentModel.fromJson(Map<String, dynamic> json) {
    this.torrentId = json['torrent_id'];
    this.series = SeriesModel.fromJson(json['series']);
    this.quality = QualityModel.fromJson(json['quality']);
    this.leechers = json['leechers'];
    this.seeders = json['seeders'];
    this.downloads = json['downloads'];
    this.totalSize = json['total_size'];
    this.uploadedTimestamp = json['uploaded_timestamp'];
    this.metadata = json['metadata'];
    this.rawBase64File = json['raw_base64_file'];
  }

  static List<TorrentModel> listFromJson(list) =>
      List<TorrentModel>.from(list.map((json) => TorrentModel.fromJson(json)));
}

class QualityModel {
  late final String string;
  late final String type;
  late final int resolution;
  late final String encoder;
  late final bool lqAudio;

  QualityModel({
    required this.string,
    required this.type,
    required this.resolution,
    required this.encoder,
    required this.lqAudio,
  });

  QualityModel.fromJson(Map<String, dynamic> json) {
    this.string = json['string'];
    this.type = json['type'];
    this.resolution = json['resolution'];
    this.encoder = json['encoder'];
    this.lqAudio = json['lq_audio'];
  }
}
