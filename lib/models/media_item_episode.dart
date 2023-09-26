import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../extensions/json_converters.dart';

part 'media_item_episode.g.dart';

@JsonSerializable()
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
  final String videoFileUrl;

  /// ссылка на файл субтитров
  final String subtitlesFileUrl;

  /// варианты качества видео
  final List<int> qualities;

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
  double get percentPosition =>
      ((position / duration) / 0.05).ceilToDouble() * 0.05;

  /// был ли эпизод полностью просмотрен
  @ignore
  bool get isSeen => percentPosition > 0.95;

  @ignore
  bool get hasShowNumbers => seasonNumber > 0 && episodeNumber > 0;
}
