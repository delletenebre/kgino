import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../api/filmix_api_provider.dart';
import '../../../extensions/json_converters.dart';
import '../media_item.dart';
import '../media_item_episode.dart';
import '../media_item_season.dart';
import 'flmx_player_links.dart';
import 'flmx_show_link.dart';

part 'filmix_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
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
    super.subtitlesEnabled,
    super.bookmarked,
    super.imdbRating,
    super.kinopoiskRating,
    super.seasons,
    super.voiceActing,
    super.voiceActings,
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
                    (e as List<dynamic>).asMap().map((k, e) {
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

      if (super.voiceActing.isEmpty) {
        voiceActing = voiceActings.keys.first;
      }

      seasons = [];

      for (final (seasonIndex, seasonEntry) in playlist.entries.indexed) {
        if (seasonEntry.value.containsKey(voiceActing)) {
          final seasonNumber = seasonEntry.key;
          final episodes = <MediaItemEpisode>[];
          for (final (episodeIndex, episodeEntry)
              in (seasonEntry.value[voiceActing] as Map).entries.indexed) {
            final episodeNumber = episodeEntry.key;
            final showLink = episodeEntry.value as FlmxShowLink;
            episodes.add(MediaItemEpisode(
              id: '$seasonNumber/$episodeNumber',
              seasonNumber: seasonIndex + 1,
              episodeNumber: episodeIndex + 1,
              videoFileUrl: showLink.link,
              qualities: showLink.qualities,
            ));
          }
          seasons.add(MediaItemSeason(
            name: seasonEntry.key,
            episodes: episodes,
          ));
        }
      }
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
    required int episodeIndex,
  }) async {
    final api = ref.read(filmixApiProvider);
    final episodes = this.episodes();

    if (episodeIndex < episodes.length) {
      final episode = episodes[episodeIndex];
      return episode.videoFileUrl.replaceFirst('_%s.', '_480.');
    }

    return '';
  }
}
