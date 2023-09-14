import 'package:isar/isar.dart';

import 'kgino_item.dart';

part 'episode_item.g.dart';

@collection
class EpisodeItem {
  /// внутренний идентификатор в базе данных
  Id get isarId => fastHash(fullId);

  /// идентификатор эпизода
  final String id;

  /// полный идентификатор эпизода
  final String fullId;

  /// название эпизода
  final String name;

  /// последняя позиция просмотра эпизода (в секундах)
  int position;

  /// продолжительность эпизода (в секундах)
  int duration;

  /// дата последнего просмотра
  DateTime? updatedAt;

  /// номер сезона
  final int seasonNumber;

  /// номер эпизода в сезоне
  final int episodeNumber;

  /// ссылка на проигрываемый файл
  String videoFileUrl;

  /// ссылка на файл субтитров
  String subtitlesFileUrl;

  /// варианты качества видео
  List<int> playableQualities;

  @Ignore()
  int quality;

  EpisodeItem({
    required this.id,
    required this.fullId,
    this.name = '',
    this.position = 0,
    this.duration = 1,
    this.updatedAt,
    this.seasonNumber = 0,
    this.episodeNumber = 0,
    this.videoFileUrl = '',
    this.subtitlesFileUrl = '',
    this.playableQualities = const [],
    this.quality = 0,
  });

  /// просмотренная позиция в пределах от 0 до 1 (шаг 5%)
  @ignore
  double get percentPosition =>
      ((position / duration) / 0.05).ceilToDouble() * 0.05;

  /// был ли эпизод полностью просмотрен
  @ignore
  bool get isSeen => percentPosition > 0.95;

  @ignore
  bool get hasShowNumbers => seasonNumber > 0 && episodeNumber > 0;

  static String getFullId(String provider, String itemId, String episodeId) {
    return '$provider/$itemId/$episodeId';
  }
}
