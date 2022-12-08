import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'episode_item.dart';
import 'season_item.dart';

part 'movie_item.g.dart';

@HiveType(typeId: 7)
enum MovieItemType {
  @HiveField(0) ockg,
  @HiveField(1) tskg,
}

@HiveType(typeId: 11)
class MovieItem extends HiveObject with EquatableMixin {
  
  /// идентификатор сайта
  @HiveField(0) final MovieItemType type;
  
  /// идентификатор фильма или сериала
  @HiveField(1) final String id;

  /// название фильма или сериала
  @HiveField(2) final String name;

  /// постер фильма или сериала
  @HiveField(3) String posterUrl;

  /// включены или выключены субтитры
  @HiveField(4) bool subtitlesEnabled;

  /// включены или выключены субтитры
  @HiveField(5) bool favorite;

  /// дата последнего просмотра
  @HiveField(6) DateTime updatedAt;

  /// список просмотренных эпизодов
  @HiveField(7) List<EpisodeItem> episodes;

  /// список сезонов
  List<SeasonItem> seasons;

  /// оригинальное название
  final String originalName;
  
  /// описание фильма или сериала
  final String description;
  
  /// год выхода в прокат
  final String year;

  /// жанры
  final List<String> genres;

  /// страны
  final List<String> countries;

  
  /// ключ, по которому сохраняем в БД
  String get storageKey => '$type.$id';

  /// количество эпизодов во всех сезонах
  int get episodeCount => seasons.fold(0, (previousValue, season) {
    return previousValue + season.episodes.length;
  });

  MovieItem({
    required this.type,
    required this.id,
    required this.name,
    required this.posterUrl,

    this.subtitlesEnabled = false,
    this.favorite = false,
    DateTime? updatedAt,

    this.episodes = const [],
    this.seasons = const [],

    this.originalName = '',
    this.description = '',
    this.year = '',
    this.genres = const [],
    this.countries = const [],
  }) : updatedAt = updatedAt ?? DateTime.now();
  
  @override
  List<Object> get props => [type, id];
  
  
  // @With<TskgMovieItemMixin>()
  // factory MovieItem.tskg({
  //   @Default(MovieItemType.tskg) MovieItemType type,
  //   required String id,
  //   required String name,
  //   required String posterUrl,
  //   @Default(false) bool subtitlesEnabled,
  //   @Default(false) bool favorite,
  //   required DateTime updatedAt,
  //   @Default({}) Map<String, EpisodeItem> episodes,
  //   @Default([]) List<SeasonItem> seasons,
  //   @Default('') String originalName,
  //   @Default('') String description,
  //   @Default('') String year,
  //   @Default([]) List<String> genres,
  //   @Default([]) List<String> countries,

  //   @Default('') String voiceActing,
  //   @Default([]) List<MovieItem> voiceActings,
  // }) = TskgMovieItem;

  // factory MovieItem.empty() = MovieItem();

  

  // /// метод для получения ссылки на проигрываемый файл
  // Future<String> streamUrl() { return Future<String>(() { return ''; }); }
  
}


mixin TskgMovieItemMixin {
  String get voiceActing;
  List<MovieItem> get voiceActings;
}

class TskgMovieItem extends MovieItem {
  
  /// текущая озвучка
  final String voiceActing;

  /// список доступных озвучек
  final List<MovieItem> voiceActings;
  
  TskgMovieItem({
    required String id,
    required String name,
    this.voiceActing = '',
    this.voiceActings = const [],
  }) : super(
    type: MovieItemType.tskg,
    id: id,
    name: name,
    posterUrl: 'https://www.ts.kg/posters/$id.png',
  );
  
}







// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive/hive.dart';

// import '../api/tskg_api_provider.dart';
// import 'episode_item.dart';
// import 'season_item.dart';

// part 'movie_item.freezed.dart';
// part 'movie_item.g.dart';

// @HiveType(typeId: 7)
// enum MovieItemType {
//   @HiveField(0) ockg,
//   @HiveField(1) tskg,
// }

// @unfreezed
// class MovieItem extends HiveObject with _$MovieItem {
//   @HiveType(typeId: 10, adapterName: 'MovieItemAdapter')
//   MovieItem._();

//   @HiveType(typeId: 11)
//   factory MovieItem({
//     /// идентификатор сайта
//     @HiveField(0) required final MovieItemType type,
    
//     /// идентификатор фильма или сериала
//     @HiveField(1) required final String id,

//     /// название фильма или сериала
//     @HiveField(2) required final String name,

//     /// постер фильма или сериала
//     @HiveField(3) required String posterUrl,

//     /// включены или выключены субтитры
//     @HiveField(4) @Default(false) bool subtitlesEnabled,

//     /// включены или выключены субтитры
//     @HiveField(5) @Default(false) bool favorite,

//     /// дата последнего просмотра
//     @HiveField(6) required DateTime updatedAt,

//     /// список просмотренных эпизодов
//     @HiveField(7) @Default({}) Map<String, EpisodeItem> episodes,

//     /// список сезонов
//     @Default([]) List<SeasonItem> seasons,

//     /// оригинальное название
//     @Default('') final String originalName,
    
//     /// описание фильма или сериала
//     @Default('') final String description,
    
//     /// год выхода в прокат
//     @Default('') final String year,

//     /// жанры
//     @Default([]) final List<String> genres,

//     /// страны
//     @Default([]) final List<String> countries,
    
//   }) = _MovieItem;
  
//   // @With<TskgMovieItemMixin>()
//   // factory MovieItem.tskg({
//   //   @Default(MovieItemType.tskg) MovieItemType type,
//   //   required String id,
//   //   required String name,
//   //   required String posterUrl,
//   //   @Default(false) bool subtitlesEnabled,
//   //   @Default(false) bool favorite,
//   //   required DateTime updatedAt,
//   //   @Default({}) Map<String, EpisodeItem> episodes,
//   //   @Default([]) List<SeasonItem> seasons,
//   //   @Default('') String originalName,
//   //   @Default('') String description,
//   //   @Default('') String year,
//   //   @Default([]) List<String> genres,
//   //   @Default([]) List<String> countries,

//   //   @Default('') String voiceActing,
//   //   @Default([]) List<MovieItem> voiceActings,
//   // }) = TskgMovieItem;

//   factory MovieItem.empty() = EmptyMovieItem;

//   // /// метод для получения ссылки на проигрываемый файл
//   // Future<String> streamUrl() { return Future<String>(() { return ''; }); }
  
// }


// // mixin TskgMovieItemMixin {
// //   String get voiceActing;
// //   List<MovieItem> get voiceActings;
// // }

// mixin TskgMovieItem extends MovieItem {
//   String get voiceActing;
//   List<MovieItem> get voiceActings;
// }
