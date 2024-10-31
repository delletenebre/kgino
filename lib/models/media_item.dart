import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../extensions/duration_extensions.dart';
import '../extensions/enum_extensions.dart';
import '../resources/kika_storage.dart';
import 'filmix/filmix_item.dart';
import 'media_item_episode.dart';
import 'media_item_season.dart';
import 'media_item_url.dart';
import 'rezka/rezka_item.dart';
import 'tmdb/tmdb_item.dart';
import 'tskg/tskg_item.dart';
import 'voice_acting.dart';

export 'media_item_episode.dart';
export 'media_item_season.dart';
export 'voice_acting.dart';

/// онлайн-сервисы
enum OnlineService {
  none,
  filmix,
  rezka,
  tskg;

  String get logo {
    switch (this) {
      case OnlineService.tskg:
        return 'assets/images/tskg.svg';
      case OnlineService.filmix:
        return 'assets/images/filmix.svg';
      case OnlineService.rezka:
        return 'assets/images/rezka.png';
      case OnlineService.none:
        return '';
    }
  }
}

/// тип медиа-контента
enum MediaItemType {
  show,
  movie,
  folder,
  error,
}

abstract interface class Playable {
  Future<MediaItem> loadDetails(Ref ref, CancelToken? cancelToken);
  Future<List<MediaItemSeason>> loadSeasons(Ref ref);
  Future<List<VoiceActing>> loadVoices(Ref ref);
  Future<MediaItemUrl> loadEpisodeUrl(WidgetRef ref, MediaItemEpisode episode);
}

class MediaItem implements Playable {
  static final store = stringMapStoreFactory.store('media_items');

  /// идентификатор в базе данных
  String get dbId => '${onlineService.name}|$id';

  /// онлайн-сервис
  final OnlineService onlineService;

  /// идентификатор на сервисе
  String id;

  /// название
  final String title;

  /// постер
  final String poster;

  /// изображение на фон
  String get backdrop => tmdb?.backdropUrl ?? poster;

  /// тип контента
  MediaItemType type;

  /// выбранное качество видео
  String quality;

  /// выбранный вариант озвучки
  VoiceActing voiceActing;

  /// включены ли субтитры
  bool subtitlesEnabled;

  /// дата добавления в избранное
  Timestamp? bookmarked;

  /// дата добавления в историю
  Timestamp? historied;

  /// оригинальное название
  final String originalTitle;

  /// описание
  final String overview;

  String get overviewText {
    return (tmdb?.overview != null && langdetect.detect(tmdb!.overview) == 'ru')
        ? tmdb!.overview
        : overview;
  }

  /// год
  String year;

  /// жанры
  final List<String> genres;

  /// страны
  final List<String> countries;

  /// количество сезонов
  final int seasonCount;

  /// рейтинг IMDb
  double imdbRating;
  bool get hasImdbRating => imdbRating > 0.0;

  /// рейтинг КиноПоиск
  double kinopoiskRating;
  bool get hasKinopoiskRating => kinopoiskRating > 0.0;

  /// сезоны
  List<MediaItemSeason> seasons;

  /// варианты озвучки
  List<VoiceActing> voices;

  /// TMDB
  TmdbItem? tmdb;

  MediaItem({
    this.onlineService = OnlineService.none,
    this.id = '',
    this.title = '',
    this.poster = '',
    this.quality = '',
    this.voiceActing = const VoiceActing(),
    this.subtitlesEnabled = true,
    this.bookmarked,

    /// не в базе данных
    required this.type,
    this.originalTitle = '',
    this.overview = '',
    this.year = '',
    this.genres = const [],
    this.countries = const [],
    this.seasonCount = 0,
    this.imdbRating = 0.0,
    this.kinopoiskRating = 0.0,
    this.seasons = const [],
    this.voices = const [],
    this.blockedStatus,

    ///
    this.tmdb,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) => MediaItem(
        blockedStatus: json['blockedStatus'] as String?,
        bookmarked: Timestamp.tryParse('${json['bookmarked']}'),
        countries:
            (json['countries'] as List<dynamic>?)?.map((e) => '$e').toList() ??
                const [],
        genres: (json['genres'] as List<dynamic>?)?.map((e) => '$e').toList() ??
            const [],
        id: json['id'] == null ? '' : '${json['id']}',
        imdbRating: double.tryParse('${json['imdbRating']}') ?? 0.0,
        kinopoiskRating: double.tryParse('${json['kinopoiskRating']}') ?? 0.0,
        onlineService: OnlineService.values
            .byNameOr('${json['onlineService']}', OnlineService.none),
        originalTitle: json['originalTitle'] as String? ?? '',
        overview: json['overview'] as String? ?? '',
        poster: json['poster'] as String? ?? '',
        quality: json['quality'] as String? ?? '',
        seasonCount: (json['seasonCount'] as num?)?.toInt() ?? 0,
        seasons: (json['seasons'] as List<dynamic>?)
                ?.map(
                    (e) => MediaItemSeason.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        subtitlesEnabled: json['subtitlesEnabled'] as bool? ?? true,
        title: json['title'] as String? ?? '',
        type: MediaItemType.values.byNameOr('${json['type']}'),
        voiceActing: json['voiceActing'] == null
            ? const VoiceActing()
            : VoiceActing.fromJson(json['voiceActing'] as Map<String, dynamic>),
        voices: (json['voices'] as List<dynamic>?)
                ?.map((e) => VoiceActing.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        year: json['year'] == null ? '' : '${json['year']}',
      )..historied = Timestamp.tryParse('${json['historied']}');

  Map<String, dynamic> toJson() => <String, dynamic>{
        'blockedStatus': blockedStatus,
        'bookmarked': bookmarked?.toIso8601String(),
        'countries': countries,
        'genres': genres,
        'historied': historied?.toIso8601String(),
        'id': id,
        'imdbRating': imdbRating,
        'kinopoiskRating': kinopoiskRating,
        'onlineService': onlineService.name,
        'originalTitle': originalTitle,
        'overview': overview,
        'poster': poster,
        'quality': quality,
        'seasonCount': seasonCount,
        'seasons': seasons.map((e) => e.toJson()).toList(),
        'subtitlesEnabled': subtitlesEnabled,
        'title': title,
        'type': type.name,
        'voiceActing': voiceActing.toJson(),
        'voices': voices.map((e) => e.toJson()).toList(),
        'year': year,
      };

  Map<String, dynamic> toDbJson() => <String, dynamic>{
        'onlineService': onlineService.name,
        'id': id,
        'title': title,
        'poster': poster,
        'type': type.name,
        'quality': quality,
        'voiceActing': voiceActing.toJson(),
        'subtitlesEnabled': subtitlesEnabled,
        'bookmarked': bookmarked?.toIso8601String(),
        'historied': historied?.toIso8601String(),
      };

  /// является ли текущий элемент "директорией"
  bool get isFolder => (type == MediaItemType.folder);

  /// является ли текущий элемент "НЕ директорией"
  bool get isNotFolder => (type != MediaItemType.folder);

  /// является ли текущий элемент "кнопкой ошибки"
  bool get isError => (type == MediaItemType.error);

  /// является ли текущий элемент "сериалом"
  bool get isShow => (type == MediaItemType.show);

  /// заблокирован ли контент правообладателем
  bool get blocked => blockedStatus?.isNotEmpty == true;

  final String? blockedStatus;

  /// продолжительность для информации
  String overviewDuration(BuildContext context) {
    switch (type) {
      case MediaItemType.folder:
      case MediaItemType.error:
        return '';
      case MediaItemType.show:
        return localeSeasonsCount(seasonCount);
      case MediaItemType.movie:
        return Duration(
                seconds:
                    seasons.firstOrNull?.episodes.firstOrNull?.duration ?? 0)
            .formatted;
    }
  }

  /// усреднённый рейтинг
  double get averageRating {
    int ratingsCount = 0;
    if (hasImdbRating) {
      ratingsCount++;
    }

    if (hasKinopoiskRating) {
      ratingsCount++;
    }

    if (ratingsCount == 0) {
      return 0.0;
    }

    return (imdbRating + kinopoiskRating) / ratingsCount;
  }

  /// отображаемый рейтинг
  String get ratingStars {
    if (averageRating == 0.0) {
      return '';
    } else if (averageRating < 5.0) {
      return '☆☆☆';
    } else if (averageRating < 6.0) {
      return '★☆☆';
    } else if (averageRating < 7.7) {
      return '★★☆';
    } else {
      return '★★★';
    }
  }

  /// общий список всех эпизодов
  List<MediaItemEpisode> get episodes =>
      seasons.expand((season) => season.episodes).toList();

  String localeSeasonsCount(int count) {
    return Intl.pluralLogic(
      count,
      locale: 'ru',
      other: '$count сезона',
      many: '$count сезонов',
      few: '$count сезона',
      one: '$count сезон',
      zero: '$count сезонов',
    );
  }

  /// загрузка подробных данных о сериале или фильме
  @override
  loadDetails(Ref ref, CancelToken? cancelToken) => throw UnimplementedError();

  /// получение списка сезонов
  @override
  loadSeasons(Ref ref) => throw UnimplementedError();

  /// получение списка вариантов озвучки
  @override
  loadVoices(Ref ref) => throw UnimplementedError();

  /// получение ссылки на эпизод
  @override
  loadEpisodeUrl(WidgetRef ref, MediaItemEpisode episode) async {
    if (episode.videoFileUrl.isNotEmpty) {
      return MediaItemUrl(video: episode.videoFileUrl);
    }

    throw UnimplementedError();
  }

  Future<TmdbItem?> loadTmdb({MediaItemType? type, String? year}) async {
    final tmdb = TMDB(
      ApiKeys(
        '5e2d902fe9f3d1307e3f2e742b52e631',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZTJkOTAyZmU5ZjNkMTMwN2UzZjJlNzQyYjUyZTYzMSIsIm5iZiI6MTcyMzU0MzU0MC40ODQzMjksInN1YiI6IjYzNzkyMmQ1OTc2ZTQ4MDBkY2Q5NDBhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rujgHr1qBSJ9gnevLd_1wOr-f5ZkN3Mkqw-LM1tDUWA',
      ),
      defaultLanguage: 'ru-RU',
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
        showInfoLogs: true,
        showUrlLogs: true,
      ),
    );

    final query = originalTitle.isNotEmpty ? originalTitle : title;

    Map search = {};

    if ((type ?? this.type) == MediaItemType.show) {
      search = await tmdb.v3.search
          .queryTvShows(query, firstAirDateYear: (year ?? this.year));
    } else if ((type ?? this.type) == MediaItemType.movie) {
      search = await tmdb.v3.search.queryMovies(query,
          year: int.tryParse((year ?? this.year).toString()));
    }

    final searchResults = search['results'] as List? ?? [];
    if (searchResults.isNotEmpty) {
      final tmdbItem = TmdbItem.fromJson(searchResults.first);

      this.tmdb = tmdbItem;

      return tmdbItem;
    }

    return null;
  }

  /// находим сохранённый в базе данных сериал или фильм
  MediaItem findSaved(KikaStorage storage) {
    final savedItemJson = store.record(dbId).getSync(storage.db);
    if (savedItemJson != null) {
      final savedItem = MediaItem.fromJson(savedItemJson);
      switch (savedItem.onlineService) {
        case OnlineService.none:
          return savedItem;
        case OnlineService.filmix:
          return FilmixItem.fromJson(savedItem.toJson());
        case OnlineService.tskg:
          return TskgItem.fromJson(savedItem.toJson());
        case OnlineService.rezka:
          return RezkaItem.fromJson(savedItem.toJson());
      }
    }

    return this;
  }

  /// сохранение в базу данных
  Future<void> save(KikaStorage storage) async {
    await store.record(dbId).put(storage.db, toDbJson());
  }

  static Future<MediaItem?> fromDb(KikaStorage storage, String id) async {
    final json = await store.record(id).get(storage.db);
    if (json != null) {
      return MediaItem.fromJson(json);
    }

    return null;
  }

  MediaItem savedSync(KikaStorage storage) {
    return fromDbSync(storage, dbId) ?? this;
  }

  static MediaItem? fromDbSync(KikaStorage storage, String id) {
    final json = store.record(id).getSync(storage.db);
    if (json != null) {
      return MediaItem.fromJson(json);
    }

    return null;
  }

  MediaItem fromDatabase() {
    if (onlineService == OnlineService.filmix) {
      return FilmixItem.fromJson(toJson());
    }
    if (onlineService == OnlineService.tskg) {
      return TskgItem.fromJson(toJson());
    }
    if (onlineService == OnlineService.rezka) {
      return RezkaItem.fromJson(toJson());
    }

    throw Exception();
  }

  // int fastHash(String string) {
  //   var hash = 0xcbf29ce484222325;

  //   var i = 0;
  //   while (i < string.length) {
  //     final codeUnit = string.codeUnitAt(i++);
  //     hash ^= codeUnit >> 8;
  //     hash *= 0x100000001b3;
  //     hash ^= codeUnit & 0xFF;
  //     hash *= 0x100000001b3;
  //   }

  //   return hash;
  // }
}
