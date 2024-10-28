import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

import '../resources/kika_storage.dart';

class MediaItemEpisode {
  static final store = stringMapStoreFactory.store('episodes');

  /// идентификатор эпизода
  final String id;

  /// название эпизода
  final String name;

  /// номер сезона
  final int seasonNumber;

  /// номер эпизода в сезоне
  final int episodeNumber;

  /// ссылка на проигрываемый файл
  final String videoFileUrl;

  /// ссылка на файл субтитров
  final String subtitlesFileUrl;

  /// варианты качества видео
  final List<String> qualities;

  /// дата последнего просмотра
  Timestamp? updatedAt;

  /// последняя позиция просмотра эпизода (в секундах)
  int position;

  /// продолжительность эпизода (в секундах)
  int duration;

  /// является ли потоковым видео
  bool isLiveStream;

  MediaItemEpisode({
    this.id = '',
    this.name = '',
    this.seasonNumber = 0,
    this.episodeNumber = 0,
    this.videoFileUrl = '',
    this.qualities = const [],
    this.subtitlesFileUrl = '',
    this.updatedAt,
    this.position = 0,
    this.duration = 0,
    this.isLiveStream = false,
  });

  factory MediaItemEpisode.fromJson(Map<String, dynamic> json) =>
      MediaItemEpisode(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        seasonNumber: int.tryParse(json['seasonNumber']) ?? 0,
        episodeNumber: int.tryParse(json['episodeNumber']) ?? 0,
        videoFileUrl: json['videoFileUrl'] as String? ?? '',
        qualities: (json['qualities'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        subtitlesFileUrl: json['subtitlesFileUrl'] as String? ?? '',
        updatedAt: Timestamp.tryParse('${json['updatedAt']}'),
        position: int.tryParse(json['position']) ?? 0,
        duration: int.tryParse(json['duration']) ?? 0,
        isLiveStream: json['isLiveStream'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'seasonNumber': seasonNumber,
        'episodeNumber': episodeNumber,
        'videoFileUrl': videoFileUrl,
        'subtitlesFileUrl': subtitlesFileUrl,
        'qualities': qualities,
        'updatedAt': updatedAt?.toIso8601String(),
        'position': position,
        'duration': duration,
        'isLiveStream': isLiveStream,
      };

  Map<String, dynamic> toDbJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'seasonNumber': seasonNumber,
        'episodeNumber': episodeNumber,
        'updatedAt': updatedAt,
        'position': position,
        'duration': duration,
        'isLiveStream': isLiveStream,
      };

  @override
  String toString() => toJson().toString();

  /// просмотренная позиция в пределах от 0 до 1 (шаг 5%)
  // @ignore
  double get viewed => duration == 0
      ? 0.0
      : ((position / duration) / 0.05).ceilToDouble() * 0.05;

  /// был ли эпизод полностью просмотрен
  // @ignore
  bool get isSeen => viewed > 0.9;

  // @ignore
  bool get hasShowNumbers => seasonNumber > 0 && episodeNumber > 0;

  /// сохранение в базу данных
  Future<void> save(KikaStorage storage) async {
    updatedAt = Timestamp.now();
    await store.record(id).put(storage.db, toDbJson());
  }

  Future<int> savedPosition(KikaStorage storage) async {
    return (await fromDb(storage, id))?.position ?? 0;
  }

  Future<MediaItemEpisode> saved(KikaStorage storage) async {
    return (await fromDb(storage, id)) ?? this;
  }

  static Future<MediaItemEpisode?> fromDb(
      KikaStorage storage, String id) async {
    final json = await store.record(id).get(storage.db);
    if (json != null) {
      return MediaItemEpisode.fromJson(json);
    }

    return null;
  }

  String nameOr(String fallback) {
    if (name.isEmpty) {
      return fallback;
    } else {
      return name;
    }
  }

  // (String, String) getMediaItemIds() {
  //   final ids = (id.split('@').firstOrNull ?? '').split('|');
  //   if (ids.length == 2) {
  //     // final onlineService = OnlineService.values
  //     //     .firstWhere((e) => e.toString() == 'OnlineService.${ids[0]}');
  //     final onlineService = ids[0];
  //     final id = ids[1];

  //     return (onlineService, id);
  //   }
  //   return ('', '');
  // }
}
