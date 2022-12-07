import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'movie_item.freezed.dart';
part 'movie_item.g.dart';

@unfreezed
class MovieItem extends HiveObject with _$MovieItem {
  @HiveType(typeId: 5)
  factory MovieItem({
    /// идентификатор сайта
    @HiveField(0) required final String tag,
    
    /// идентификатор фильма или сериала
    @HiveField(1) required final String id,

    /// название фильма или сериала
    @HiveField(2) required final String name,

    /// постер фильма или сериала
    @HiveField(3) required final String posterUrl,

    /// включены или выключены субтитры
    @HiveField(4) @Default(false) bool subtitlesEnabled,

    /// дата последнего просмотра
    @HiveField(5) required DateTime updatedAt,

    /// список просмотренных эпизодов
    @HiveField(6) @Default({}) Map<String, SeenEpisode> episodes,
    
  }) = _MovieItem;
      
}

@unfreezed
class EpisodeItem extends HiveObject with _$EpisodeItem {
  EpisodeItem._();
  
  @HiveType(typeId: 6)
  factory EpisodeItem({
    /// идентификатор эпизода
    @HiveField(0) required final String id,

    /// название фильма или сериала
    @HiveField(2) required final String name,

    /// время просмотра эпизода (в секундах)
    @HiveField(1) @Default(0) int position,

    /// продолжительность эпизода (в секундах)
    @HiveField(2) required final int duration,

    /// дата последнего просмотра
    @HiveField(5) required DateTime updatedAt,
    
  }) = _EpisodeItem;

  /// просмотренная позиция в пределах от 0 до 1
  /// + 0.01 чтобы не получилось деления на ноль
  double get percentPosition => position / (duration + 0.0001);
      
}
