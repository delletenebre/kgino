import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'episode_item.g.dart';

@HiveType(typeId: 12)
class EpisodeItem extends HiveObject with EquatableMixin {
  
  /// идентификатор эпизода
  @HiveField(0) final String id;

  /// название эпизода
  @HiveField(1) final String name;

  /// последняя позиция просмотра эпизода (в секундах)
  @HiveField(2) int position;

  /// продолжительность эпизода (в секундах)
  @HiveField(3) final int duration;

  /// дата последнего просмотра
  @HiveField(4) DateTime updatedAt;

  /// номер сезона
  @HiveField(5) final int seasonNumber;

  /// номер эпизода в сезоне
  @HiveField(6) final int episodeNumber;

  /// ссылка на проигрываемый файл
  String videoFileUrl;

  /// ссылка на файл субтитров
  String subtitlesFileUrl;

  EpisodeItem({
    required this.id,
    required this.name,

    this.position = 0,
    this.duration = 1,
    DateTime? updatedAt,

    this.seasonNumber = 0,
    this.episodeNumber = 0,

    this.videoFileUrl = '',
    this.subtitlesFileUrl = '',
    
  }) : updatedAt = updatedAt ?? DateTime.now();

  @override
  List<Object> get props => [id];


  /// просмотренная позиция в пределах от 0 до 1
  double get percentPosition => position / duration;

  

}
