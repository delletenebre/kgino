import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../api/tskg_api_provider.dart';
import 'episode_item.dart';

part 'movie_item.freezed.dart';
part 'movie_item.g.dart';

@HiveType(typeId: 7)
enum SiteType {
  @HiveField(0) ockg,
  @HiveField(1) tskg,
}

@unfreezed
class MovieItem extends HiveObject with _$MovieItem {
  MovieItem._();

  @HiveType(typeId: 5)
  factory MovieItem({
    /// идентификатор сайта
    @HiveField(0) required final SiteType type,
    
    /// идентификатор фильма или сериала
    @HiveField(1) required final String id,

    /// название фильма или сериала
    @HiveField(2) required final String name,

    /// постер фильма или сериала
    @HiveField(3) required String posterUrl,

    /// включены или выключены субтитры
    @HiveField(4) @Default(false) bool subtitlesEnabled,

    /// включены или выключены субтитры
    @HiveField(5) @Default(false) bool favorite,

    /// дата последнего просмотра
    @HiveField(6) required DateTime updatedAt,

    /// список просмотренных эпизодов
    @HiveField(7) @Default({}) Map<String, EpisodeItem> episodes,

    /// оригинальное название
    @Default('') final String originalName,
    
    /// описание фильма или сериала
    @Default('') final String description,
    
    /// год выхода в прокат
    @Default('') final String year,

    /// жанры
    @Default([]) final List<String> genres,

    /// страны
    @Default([]) final List<String> countries,
    
  }) = _MovieItem;
  
  @With<TskgMovieItemMixin>()
  factory MovieItem.tskg({
    @Default(SiteType.tskg) SiteType type,
    required String id,
    required String name,
    required String posterUrl,
    required bool subtitlesEnabled,
    required bool favorite,
    required DateTime updatedAt,
    @Default({}) Map<String, EpisodeItem> episodes,
    @Default('') String originalName,
    @Default('') String description,
    @Default('') String year,
    @Default([]) List<String> genres,
    @Default([]) List<String> countries,
  }) = TskgMovieItem;

  // /// метод для получения ссылки на проигрываемый файл
  // Future<String> streamUrl() { return Future<String>(() { return ''; }); }
  
}


mixin TskgMovieItemMixin {
}
