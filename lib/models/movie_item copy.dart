// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:hive/hive.dart';

// part 'movie_item.g.dart';

// @HiveType(typeId: 7)
// enum SiteType {
//   @HiveField(0) ockg,
//   @HiveField(1) tskg,
// }

// @HiveType(typeId: 5)
// class MovieItem extends HiveObject {
  
//   /// идентификатор сайта
//   @HiveField(0) final SiteType type;
  
//   /// идентификатор фильма или сериала
//   @HiveField(1) final String id;

//   /// название фильма или сериала
//   @HiveField(2) final String name;

//   /// постер фильма или сериала
//   @HiveField(3) String posterUrl;

//   /// включены или выключены субтитры
//   @HiveField(4) bool subtitlesEnabled;

//   /// дата последнего просмотра
//   @HiveField(5) DateTime updatedAt;

//   /// список просмотренных эпизодов
//   @HiveField(6) Map<String, EpisodeItem> episodes;

//   /// оригинальное название
//   final String originalName;
  
//   /// описание фильма или сериала
//   final String description;
  
//   /// год выхода в прокат
//   final String year;

//   /// жанры
//   final List<String> genres;

//   /// страны
//   final List<String> countries;

//   MovieItem({
//     required this.type,
//     required this.id,
//     required this.name,
//     required this.posterUrl,
//     this.subtitlesEnabled = false,
//     DateTime? updatedAt,
//     this.episodes = const {},
//     required this.originalName,
//     required this.description,
//     required this.year,
//     required this.genres,
//     required this.countries
//   }) : updatedAt = updatedAt ?? DateTime.now();

//   factory MovieItem.tskg({
//     required String id,
//     required String name,
//     required String posterUrl,
//     bool subtitlesEnabled = false,
//     DateTime? updatedAt,
//     Map<String, EpisodeItem> episodes = const {},
//     String originalName = '',
//     String description = '',
//     String year = '',
//     List<String> genres = const [],
//     List<String> countries = const [],
//   }) => MovieItem(
//     type: SiteType.tskg,
//     id: id,
//     name: name,
//     posterUrl: posterUrl,
//     subtitlesEnabled: subtitlesEnabled,
//     updatedAt: updatedAt,
//     episodes: episodes,
//     originalName: originalName,
//     description: description,
//     year: year,
//     genres: genres,
//     countries: countries,
//   );
      
// }

// // @unfreezed
// // class EpisodeItem extends HiveObject with _$EpisodeItem {
// //   EpisodeItem._();

// //   @HiveType(typeId: 6)
// //   @Assert('duration > 0')
// //   factory EpisodeItem({
// //     /// идентификатор эпизода
// //     @HiveField(0) required final String id,

// //     /// название эпизода
// //     @HiveField(1) required final String name,

// //     /// последняя позиция просмотра эпизода (в секундах)
// //     @HiveField(2) @Default(0) int position,

// //     /// продолжительность эпизода (в секундах)
// //     @HiveField(3) required final int duration,

// //     /// дата последнего просмотра
// //     @HiveField(4) DateTime? updatedAt,

// //     /// номер сезона
// //     @HiveField(5) required final int seasonNumber,

// //     /// номер эпизода в сезоне
// //     @HiveField(6) required final int episodeNumber,
    
// //   }) = _EpisodeItem;

// //   @Implements<PlayableItem>()
// //   const factory EpisodeItem.tskg(String name, int population) = TskgEpisodeItem;

// //   /// просмотренная позиция в пределах от 0 до 1
// //   double get percentPosition => position / duration;

// // }

// abstract class PlayableItem {
//   /// метод для получения ссылки на проигрываемый файл
//   Future<String> streamUrl();
// }


// @HiveType(typeId: 6)
// class EpisodeItem extends HiveObject {
  
//   /// идентификатор эпизода
//   @HiveField(0) final String id;

//   /// название эпизода
//   @HiveField(1) final String name;

//   /// последняя позиция просмотра эпизода (в секундах)
//   @HiveField(2) int position;

//   /// продолжительность эпизода (в секундах)
//   @HiveField(3) final int duration;

//   /// дата последнего просмотра
//   @HiveField(4) DateTime? updatedAt;

//   /// номер сезона
//   @HiveField(5) final int seasonNumber;

//   /// номер эпизода в сезоне
//   @HiveField(6) final int episodeNumber;
   
//   EpisodeItem({
//     required this.id,
//     required this.name,
//     this.position = 0,
//     required this.duration,
//     required this.updatedAt,
//     required this.seasonNumber,
//     required this.episodeNumber,
//   });

//   /// просмотренная позиция в пределах от 0 до 1
//   double get percentPosition => position / duration;

// }

// class TskgEpisodeItem extends EpisodeItem implements PlayableItem {
  
//   TskgEpisodeItem({
//     required super.id,
//     required super.name,
//     super.position,
//     required super.duration,
//     required super.updatedAt,
//     required super.seasonNumber, 
//     required super.episodeNumber
//   });


//   @override
//   Future<String> streamUrl() async {
//     return Future.delayed(Duration(seconds: 2));
//   }
// }