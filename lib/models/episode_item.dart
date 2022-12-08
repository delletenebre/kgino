import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'episode_item.freezed.dart';
part 'episode_item.g.dart';

@unfreezed
class EpisodeItem extends HiveObject with _$EpisodeItem {
  EpisodeItem._();

  @HiveType(typeId: 6)
  @Assert('duration > 0')
  factory EpisodeItem({
    /// идентификатор эпизода
    @HiveField(0) required final String id,

    /// название эпизода
    @HiveField(1) required final String name,

    /// последняя позиция просмотра эпизода (в секундах)
    @HiveField(2) @Default(0) int position,

    /// продолжительность эпизода (в секундах)
    @HiveField(3) required final int duration,

    /// дата последнего просмотра
    @HiveField(4) DateTime? updatedAt,

    /// номер сезона
    @HiveField(5) required final int seasonNumber,

    /// номер эпизода в сезоне
    @HiveField(6) required final int episodeNumber,

    /// ссылка на проигрываемый файл
    @Default('') String streamUrl,
    
  }) = _EpisodeItem;

  /// просмотренная позиция в пределах от 0 до 1
  double get percentPosition => position / duration;

}
