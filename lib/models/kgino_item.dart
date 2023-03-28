import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../resources/krs_storage.dart';
import 'episode_item.dart';
import 'season_item.dart';

part 'kgino_item.g.dart';

/// название (внутренний идентификатор) сервиса
enum KginoProvider {
  ockg,
  tskg,
  wcam,
  flmx,
}

@collection
class KginoItem {

  /// внутренний идентификатор в базе данных
  Id get isarId => fastHash(storageKey);

  /// идентификатор сервиса
  // @enumerated
  final String provider;
  
  /// идентификатор фильма или сериала
  final String id;

  /// название фильма или сериала
  final String name;

  /// постер фильма или сериала
  final String posterUrl;

  /// включены или выключены субтитры
  bool subtitlesEnabled;

  /// дата добавления в список закладок
  DateTime? bookmarked;

  /// список просмотренных эпизодов
  IsarLinks<EpisodeItem> seenEpisodes = IsarLinks<EpisodeItem>();

  /// текущая озвучка
  String voiceActing;

  /// текущая озвучка (срезанная)
  @ignore
  String get shortVoiceActing {
    if (voiceActing.length > 24) {
      return '${voiceActing.substring(0, 24)}...';
    }
    return voiceActing;
  }



  /// список сезонов
  @ignore
  List<SeasonItem> seasons;

  /// оригинальное название
  @ignore
  final String originalName;
  
  /// описание фильма или сериала
  @ignore
  final String description;
  
  /// год выхода в прокат
  @ignore
  final String year;

  /// жанры
  @ignore
  final List<String> genres;

  /// страны
  @ignore
  final List<String> countries;

  /// дополнительная информация (в основном вторая строка, после названия)
  @ignore
  final String subtitle;

  /// рейтинг IMDb
  @ignore
  final double imdbRating;
  bool get hasImdbRating => imdbRating > 0.0;

  /// рейтинг Кинопоиск
  @ignore
  final double kinopoiskRating;
  bool get hasKinopoiskRating => kinopoiskRating > 0.0;

  /// продолжительность
  @ignore
  final Duration duration;

  /// список доступных озвучек
  @ignore
  final List<KginoItem> voiceActings;

  /// аудио информация о наличии звуковой дорожки 5.1
  @ignore
  final bool hasSixChannels;

  /// является ли объект папкой
  @ignore
  final bool isFolder;


  KginoItem({
    required this.provider,
    required this.id,
    required this.name,
    required this.posterUrl,

    this.subtitlesEnabled = false,
    this.bookmarked,

    this.seasons = const [],

    this.originalName = '',
    this.description = '',
    this.year = '',
    this.genres = const [],
    this.countries = const [],
    this.subtitle = '',

    this.imdbRating = 0.0,
    this.kinopoiskRating = 0.0,

    this.duration = Duration.zero,

    this.voiceActing = '',
    this.voiceActings = const [],

    this.hasSixChannels = false,

    this.isFolder = false,

  });

  /// ключ для идентификатора базы данных
  @ignore
  String get storageKey => '$provider.$id';

  /// количество эпизодов во всех сезонах
  int get episodeCount => seasons.fold(0, (previousValue, season) {
    return previousValue + season.episodes.length;
  });


  /// получаем последний просмотренный эпизод
  EpisodeItem? getLastSeenEpisode() {
    if (seenEpisodes.isNotEmpty) {
      seenEpisodes.toList().sort((a, b) {
        return b.updatedAt!.compareTo(a.updatedAt!);
      });
      
      return seenEpisodes.first;
    }

    return null;
  }
  
  /// список всех эпизодов в сериале
  List<EpisodeItem> getAllEpisodes() {
    final episodes = <EpisodeItem>[];
    for (final season in seasons) {
      episodes.addAll(season.episodes);
    }
    return episodes;
  }

  /// получаем эпизод, с которого необходимо продолжить просмотр
  EpisodeItem getNextPlayableEpisode(EpisodeItem lastSeenEpisode) {
    /// получаем список эпизодов
    final episodes = getAllEpisodes();

    EpisodeItem playableEpisode = lastSeenEpisode;

    final episodeIndex = episodes.indexOf(lastSeenEpisode);
    if (episodeIndex > -1) {
      playableEpisode = episodes.elementAt(episodeIndex);
      playableEpisode.position = lastSeenEpisode.position;

      if (playableEpisode.isSeen && episodeIndex < episodes.length - 1) {
        playableEpisode = episodes.elementAt(episodeIndex + 1);
      }
    }
    
    return playableEpisode;
  }


  /// хранилище данных
  @ignore
  final storage = GetIt.instance<KrsStorage>();

  Future<void> save() async {
    await storage.db.writeTxn(() async {
      await storage.db.kginoItems.put(this);
    });
  }

  @ignore
  Stream<KginoItem?> get dbStream {
    return storage.db.kginoItems.watchObject(isarId);
  }


  // factory KginoItem.webcamera({
  //   required String name,
  //   required String posterUrl,
  //   required String videoFileUrl,
  // }) => KginoItem(
  //   type: KginoItemType.movie,
  //   provider: KginoProvider.wcam,
  //   id: '',
  //   name: name,
  //   posterUrl: posterUrl,
  //   seasons: [
  //     SeasonItem(
  //       name: '',
  //       episodes: [
  //         EpisodeItem(
  //           id: '',
  //           name: '',
  //           videoFileUrl: videoFileUrl
  //         ),
  //       ],
  //     ),
  //   ],
  // );
  
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  int hash = 0xcbf29ce484222325;

  int i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  // int hash = 0x811c9dc5;

  // int i = 0;
  // while (i < string.length) {
  //   final codeUnit = string.codeUnitAt(i++);
  //   hash ^= codeUnit >> 4;
  //   hash *= 0x01000193;
  //   hash ^= codeUnit & 0xFF;
  //   hash *= 0x01000193;
  // }

  return hash;
}
