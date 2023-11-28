import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/filmix_api_provider.dart';
import '../../enums/online_service.dart';
import '../../extensions/json_converters.dart';
import '../media_item.dart';
import '../voice_acting.dart';
import 'filmix_player_links.dart';
import 'filmix_show_link.dart';

part 'filmix_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FilmixItem extends MediaItem {
  final List<String> categories;

  /// описание
  @HtmlRemoveConverter()
  final String shortStory;

  /// ссылки на проигрываемые файлы
  final FilmixPlayerLinks? playerLinks;

  final int duration;

  FilmixItem({
    required super.id,
    required super.title,
    required super.poster,
    super.originalTitle = '',
    super.year,
    super.countries,
    super.imdbRating,
    super.kinopoiskRating,
    super.seasons,
    super.voices,
    super.onlineService = OnlineService.filmix,
    super.type = MediaItemType.unknown,
    this.categories = const [],
    this.shortStory = '',
    this.playerLinks = const FilmixPlayerLinks(),

    ///
    super.bookmarked,
    super.subtitles,
    super.voice,
    super.quality = '480',
    this.duration = 0,
  }) {
    voices = [];

    if (playerLinks != null) {
      if (playerLinks!.movie.isNotEmpty) {
        /// ^ если фильм

        type = MediaItemType.movie;

        /// доступные варианты озвучки
        voices = playerLinks!.movie.map((movie) {
          return VoiceActing(
            id: movie.translation,
            name: movie.translation,
          );
        }).toList();

        /// выбранная озвучка
        if (voice.id.isEmpty && voices.isNotEmpty) {
          voice = voices.first;
        }

        final movie = playerLinks!.movie
            .firstWhere((movie) => movie.translation == voice.id);

        final qualityRegExp = RegExp(r'\[([,\d]+)\]');
        final qualities = (qualityRegExp
                    .allMatches(movie.link)
                    .map((m) => m.group(0))
                    .firstOrNull ??
                '')
            .split(',')
            .toList()
          ..removeWhere((quality) => quality.isEmpty);

        final videoUrl = movie.link.replaceFirst(RegExp(r'(\[[,\d]+\])'), '%s');

        seasons = [
          MediaItemSeason(
            name: '',
            episodes: [
              MediaItemEpisode(
                id: '$isarId@1|1',
                seasonNumber: 1,
                episodeNumber: 1,
                videoFileUrl: videoUrl,
                qualities: qualities,
                duration: duration * 60,
              )
            ],
          )
        ];
      } else if (playerLinks!.playlist is Map) {
        /// ^ если сериал

        type = MediaItemType.show;

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
                          FilmixShowLink.fromJson(e as Map<String, dynamic>),
                        );
                      }),
                    );
                  } else {
                    return MapEntry(
                      k,
                      (e as List<dynamic>).asMap().map((k, e) {
                        return MapEntry(
                          k + 1,
                          FilmixShowLink.fromJson(e as Map<String, dynamic>),
                        );
                      }),
                    );
                  }
                } catch (exception) {
                  return const MapEntry('', <String, FilmixShowLink>{});
                }
              }),
            );
          },
        );

        /// очищаем варианты озвучки от дубликатов
        final uniqueVoiceActings =
            playlist.entries.map((e) => e.value.keys).flattened.toSet();

        /// доступные варианты озвучки
        voices = [
          for (final voiceActing in uniqueVoiceActings)
            VoiceActing(
              id: voiceActing,
              name: voiceActing,
            )
        ];

        if (voice.id.isEmpty && voices.isNotEmpty) {
          voice = voices.first;
        }

        seasons = [];

        for (final (seasonIndex, seasonEntry) in playlist.entries.indexed) {
          if (seasonEntry.value.containsKey(voice.id)) {
            final episodes = <MediaItemEpisode>[];
            for (final (episodeIndex, episodeEntry)
                in (seasonEntry.value[voice.id] as Map).entries.indexed) {
              final showLink = episodeEntry.value as FilmixShowLink;
              episodes.add(MediaItemEpisode(
                id: '$isarId@${seasonIndex + 1}|${episodeIndex + 1}',
                seasonNumber: seasonIndex + 1,
                episodeNumber: episodeIndex + 1,
                videoFileUrl: showLink.link,
                qualities: showLink.qualities.map((e) => e.toString()).toList(),
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
  }

  factory FilmixItem.fromJson(Map<String, dynamic> json) =>
      _$FilmixItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FilmixItemToJson(this);

  @override
  bool get blocked =>
      playerLinks
          ?.toJson()
          .toString()
          .contains('Заблокировано правообладателем') ==
      true;

  @override
  List<String> get genres {
    return categories..removeWhere((element) => element == 'Сериалы');
  }

  @override
  String get overview => shortStory;

  @override
  Future<MediaItem> loadDetails(Ref ref) async {
    final api = ref.read(filmixApiProvider);

    /// отменяем выполнение запроса, если страница закрыта
    final cancelToken = api.getCancelToken();
    ref.onDispose(cancelToken.cancel);

    final detailedItem = await api.getDetails(
      id: id,
      cancelToken: cancelToken,
    );

    final json = detailedItem.toJson();
    json['quality'] = quality;
    json['subtitles'] = subtitles;
    json['voice'] = voice.toJson();
    json['bookmarked'] = bookmarked?.toString();

    return FilmixItem.fromJson(json);
  }

  @override
  Future<MediaItemUrl> loadEpisodeUrl({
    required WidgetRef ref,
    required int episodeIndex,
  }) async {
    final episodes = this.episodes();

    if (episodeIndex < episodes.length) {
      final episode = episodes[episodeIndex];

      if (quality.isEmpty) {
        quality = (episode.qualities
                    .sorted((a, b) => compareNatural(a, b))
                    .lastOrNull ??
                '')
            .toString();
      }

      return MediaItemUrl(
        video: episode.videoFileUrl.replaceFirst('_%s.', '_$quality.'),
        subtitles: episode.subtitlesFileUrl,
      );
    }

    return MediaItemUrl();
  }
}
