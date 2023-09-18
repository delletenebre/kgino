import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../api/filmix_api_provider.dart';
import '../../../extensions/json_converters.dart';
import '../media_item.dart';
import 'flmx_player_links.dart';
import 'flmx_show_link.dart';

part 'filmix_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FilmixItem extends MediaItem {
  final List<String> categories;

  /// описание
  @HtmlRemoveConverter()
  final String shortStory;

  /// ссылки на проигрываемые файлы
  final FlmxPlayerLinks? playerLinks;

  FilmixItem({
    super.id,
    super.title,
    super.originalTitle = '',
    super.poster,
    super.year,
    super.countries,
    super.voiceActing,
    super.voiceActings,
    super.subtitlesEnabled,
    super.bookmarked,
    super.imdbRating,
    super.kinopoiskRating,
    //super.seasons,
    this.categories = const [],
    this.shortStory = '',
    this.playerLinks = const FlmxPlayerLinks(),
  }) {
    voiceActings = {};

    if (playerLinks != null && playerLinks!.playlist is Map) {
      /// парсим плейлист
      final playlist = (playerLinks!.playlist as Map<String, dynamic>).map(
        (k, e) {
          return MapEntry(
            k,
            (e as Map<String, dynamic>).map((k, e) {
              try {
                if (e is Map) {
                  return MapEntry(
                    k,
                    (e as Map<String, dynamic>).map((k, e) {
                      return MapEntry(
                        k,
                        FlmxShowLink.fromJson(e as Map<String, dynamic>),
                      );
                    }),
                  );
                } else {
                  return MapEntry(
                    k,
                    (e as List<dynamic>).mapIndexed((k, e) {
                      return MapEntry(
                        k + 1,
                        FlmxShowLink.fromJson(e as Map<String, dynamic>),
                      );
                    }),
                  );
                }
              } catch (exception) {
                return const MapEntry('', <String, FlmxShowLink>{});
              }
            }),
          );
        },
      );

      /// очищаем варианты озвучки от дубликатов
      final uniqueVoiceActings =
          playlist.entries.map((e) => e.value.keys).flattened.toSet();

      /// доступный варианты озвучки
      voiceActings = {
        for (final voiceActing in uniqueVoiceActings) voiceActing: voiceActing
      };
    }
  }

  factory FilmixItem.fromJson(Map<String, dynamic> json) =>
      _$FilmixItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FilmixItemToJson(this);

  @override
  List<String> get genres => categories;

  @override
  String get overview => shortStory;

  @override
  Future<MediaItem> loadDetails(Ref ref) async {
    final api = ref.read(filmixApiProvider);

    /// отменяем выполнение запроса, если страница закрыта
    final cancelToken = api.getCancelToken();
    ref.onDispose(cancelToken.cancel);

    return await api.getDetails(
      id: id,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<String> loadEpisodeUrl({
    required WidgetRef ref,
    required int seasonIndex,
    required int episodeIndex,
  }) async {
    final api = ref.read(filmixApiProvider);

    if (seasons.length < seasonIndex) {
      final season = seasons[seasonIndex];
      if (season.episodes.length < episodeIndex) {
        final episode = season.episodes[episodeIndex];
      }
    }

    // /// отменяем выполнение запроса, если страница закрыта
    // final cancelToken = api.getCancelToken();
    // ref.onDispose(cancelToken.cancel);

    // return await api.getDetails(
    //   id: id,
    //   cancelToken: cancelToken,
    // );

    return 'https://nl06.cdnsqu.com/s/FXFS0WN1567C5IozX8wnUXPAdkFBQUFBQUFBQUFBQjljRVZCUUJV/Deadliest-Catch/s17e22_480.mp4';
  }
}
