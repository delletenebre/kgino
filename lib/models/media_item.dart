import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/filmix_api_provider.dart';
import '../api/tmdb_api_provider.dart';
import 'tmdb_item.dart';

part 'media_item.freezed.dart';
part 'media_item.g.dart';

enum OnlineService {
  filmix,
  tskg,
  tmdb,
}

enum MediaItemType {
  movie,
  show,
}

@freezed
class MediaItem with _$MediaItem {
  const MediaItem._();

  factory MediaItem({
    required OnlineService onlineService,
    required MediaItemType mediaItemType,
    @Default('') String id,
    @Default('') String title,
    @Default('') String originalTitle,
    @Default('') String overview,
    String? posterImage,
    @Default([]) List<String> genres,
    @Default('') String year,
    @Default([]) List<String> countries,
    TmdbItem? tmdb,
  }) = _MediaItem;

  factory MediaItem.fromJson(Map<String, Object?> json) =>
      _$MediaItemFromJson(json);

  String get genresString => genres.take(2).join(' / ');
  String get countriesString => countries.take(2).join(' / ');

  String get backdropImage => tmdb?.backdropImage ?? posterImage ?? '';

  String get mayBeOverview =>
      overview.isNotEmpty ? overview : tmdb?.overview ?? '';

  Future<TmdbItem?> loadTmdb(AsyncNotifierProviderRef ref) async {
    final api = ref.read(tmdbApiProvider);

    /// отменяем выполнение запроса, если страница закрыта
    final cancelToken = api.getCancelToken();
    ref.onDispose(cancelToken.cancel);

    if (mediaItemType == MediaItemType.show) {
      return await api.searchShow(
        originalTitle: originalTitle,
        title: title,
        year: year,
        cancelToken: cancelToken,
      );
    } else {
      return await api.searchMovie(
        originalTitle: originalTitle,
        title: title,
        year: year,
        cancelToken: cancelToken,
      );
    }
  }

  Future<MediaItem?> loadDetails(AsyncNotifierProviderRef ref) async {
    if (onlineService == OnlineService.filmix) {
      final api = ref.read(filmixApiProvider);

      /// отменяем выполнение запроса, если страница закрыта
      final cancelToken = api.getCancelToken();
      ref.onDispose(cancelToken.cancel);

      return await api.getDetails(
        id: id,
        mediaItemType: mediaItemType,
        cancelToken: cancelToken,
      );
    }

    return null;
  }
}
