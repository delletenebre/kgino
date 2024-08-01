import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../extensions/json_converters.dart';
import '../resources/kika_storage.dart';

part 'media_item_episode.g.dart';

@JsonSerializable(explicitToJson: true)
@collection
class MediaItemEpisode {
  /// внутренний идентификатор в базе данных
  @Id()
  String get dbDb => id;

  /// идентификатор эпизода
  @StringConverter()
  final String id;

  /// название эпизода
  final String name;

  /// номер сезона
  final int seasonNumber;

  /// номер эпизода в сезоне
  final int episodeNumber;

  /// ссылка на проигрываемый файл
  @ignore
  final String videoFileUrl;

  /// ссылка на файл субтитров
  @ignore
  final String subtitlesFileUrl;

  /// варианты качества видео
  @ignore
  final List<String> qualities;

  /// дата последнего просмотра
  DateTime? updatedAt;

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
      _$MediaItemEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemEpisodeToJson(this);

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
    storage.db?.writeAsync((isar) async {
      updatedAt = DateTime.now();
      isar.mediaItemEpisodes.put(this);
    });
  }

  /// сохранение в базу данных
  int savedPosition(KikaStorage storage) {
    return storage.db?.mediaItemEpisodes.get(dbDb)?.position ?? 0;
  }

  MediaItemEpisode saved(KikaStorage storage) {
    return storage.db?.mediaItemEpisodes.get(dbDb) ?? this;
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
