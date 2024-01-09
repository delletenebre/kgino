import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../extensions/json_converters.dart';
import '../resources/krs_storage.dart';

part 'media_item_episode.g.dart';

@JsonSerializable(explicitToJson: true)
@collection
class MediaItemEpisode {
  @Id()
  String get isarDb => id;

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
  });

  factory MediaItemEpisode.fromJson(Map<String, dynamic> json) =>
      _$MediaItemEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemEpisodeToJson(this);

  /// просмотренная позиция в пределах от 0 до 1 (шаг 5%)
  @ignore
  double get viewed => ((position / duration) / 0.05).ceilToDouble() * 0.05;

  /// был ли эпизод полностью просмотрен
  @ignore
  bool get isSeen => viewed > 0.9;

  @ignore
  bool get hasShowNumbers => seasonNumber > 0 && episodeNumber > 0;

  /// сохранение в базу данных
  Future<void> save(KrsStorage storage) async {
    // TODO see restrictions listed at`SendPort.send()` documentation for more information
    // https://github.com/isar/isar/issues/1393
    storage.db.writeAsync((isar) async {
      updatedAt = DateTime.now();
      isar.mediaItemEpisodes.put(this);
    });
  }

  /// сохранение в базу данных
  int savedPosition(KrsStorage storage) {
    return storage.db.mediaItemEpisodes.get(isarDb)?.position ?? 0;
  }

  MediaItemEpisode? saved(KrsStorage storage) {
    return storage.db.mediaItemEpisodes.get(isarDb);
  }
}
