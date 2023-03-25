import 'package:isar/isar.dart';

import 'kgino_item.dart';

part 'episode_item.g.dart';

@collection
class EpisodeItem {

  /// внутренний идентификатор в базе данных
  Id get isarId => fastHash(id);
  
  /// идентификатор эпизода
  final String id;

  /// название эпизода
  final String name;

  /// последняя позиция просмотра эпизода (в секундах)
  short position;

  /// продолжительность эпизода (в секундах)
  final short duration;

  /// дата последнего просмотра
  DateTime? updatedAt;

  /// номер сезона
  final short seasonNumber;

  /// номер эпизода в сезоне
  final short episodeNumber;

  /// ссылка на проигрываемый файл
  String videoFileUrl;

  /// ссылка на файл субтитров
  String subtitlesFileUrl;

  EpisodeItem({
    required this.id,
    required this.name,

    this.position = 0,
    this.duration = 1,
    this.updatedAt,

    this.seasonNumber = 0,
    this.episodeNumber = 0,

    this.videoFileUrl = '',
    this.subtitlesFileUrl = '',
    
  });

  /// просмотренная позиция в пределах от 0 до 1
  @ignore
  double get percentPosition => position / duration;

  /// был ли эпизод полностью просмотрен
  @ignore
  bool get isSeen => percentPosition > 0.95;

}
