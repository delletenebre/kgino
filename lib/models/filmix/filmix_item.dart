import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/filmix_api_provider.dart';
import '../../extensions/json_converters.dart';
import '../media_item.dart';
import '../media_item_url.dart';
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
    super.onlineService = OnlineService.filmix,
    required super.id,
    required super.title,
    required super.poster,
    super.type = MediaItemType.movie,
    super.quality = '720',
    super.originalTitle = '',
    super.year,
    super.countries,
    super.seasons,
    super.voices,
    super.blockedStatus,
    this.categories = const [],
    this.shortStory = '',
    this.playerLinks = const FilmixPlayerLinks(),

    ///
    super.bookmarked,
    super.subtitlesEnabled,
    super.voiceActing,
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
        if (voiceActing.id.isEmpty && voices.isNotEmpty) {
          voiceActing = voices.first;
        }

        final movie = playerLinks!.movie
            .firstWhere((movie) => movie.translation == voiceActing.id);

        final qualityRegExp = RegExp(r'\[([,\d]+)\]');
        final qualities = (qualityRegExp
                    .allMatches(movie.link)
                    .map((m) => m.group(1))
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
                id: '$dbId@1|1',
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
        final uniqueVoices =
            playlist.entries.map((e) => e.value.keys).flattened.toSet();

        /// доступные варианты озвучки
        voices = [
          for (final voiceActing in uniqueVoices)
            VoiceActing(
              id: voiceActing,
              name: voiceActing,
            )
        ];

        if ((voiceActing?.id ?? '').isEmpty && voices.isNotEmpty) {
          voiceActing = voices.first;
        }

        seasons = [];

        for (final (seasonIndex, seasonEntry) in playlist.entries.indexed) {
          if (seasonEntry.value.containsKey(voiceActing?.id ?? '')) {
            final episodes = <MediaItemEpisode>[];
            for (final (episodeIndex, episodeEntry)
                in (seasonEntry.value[voiceActing?.id ?? ''] as Map)
                    .entries
                    .indexed) {
              final showLink = episodeEntry.value as FilmixShowLink;
              episodes.add(MediaItemEpisode(
                id: '$dbId@${seasonIndex + 1}|${episodeIndex + 1}',
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

  /// количество сезонов
  @override
  int get seasonCount => seasons.length;

  /// заблокирован ли контент
  @override
  String? get blockedStatus => (playerLinks
              ?.toJson()
              .toString()
              .contains('Заблокировано правообладателем') ==
          true)
      ? 'Заблокировано правообладателем'
      : null;

  /// жанры
  @override
  List<String> get genres {
    return categories..removeWhere((element) => element == 'Сериалы');
  }

  /// описание
  @override
  String get overview => shortStory;

  /// загрузка подробных данных о сериале или фильме
  @override
  Future<MediaItem> loadDetails(Ref ref, CancelToken? cancelToken) async {
    final api = ref.read(filmixApiProvider);

    /// отправляем запрос на получение данных
    final detailedItem = await api.getDetails(id: id, cancelToken: cancelToken);

    detailedItem.voiceActing = voiceActing;
    detailedItem.quality = quality;
    detailedItem.subtitlesEnabled = subtitlesEnabled;
    detailedItem.bookmarked = bookmarked;

    return detailedItem;
  }

  /// получение списка вариантов озвучки
  @override
  Future<List<VoiceActing>> loadVoices(Ref ref) async {
    /// отправляем запрос на получение данных
    return voices;
  }

  /// получение списка сезонов
  @override
  Future<List<MediaItemSeason>> loadSeasons(Ref ref) async {
    return seasons;
  }

  /// получение ссылки на воспроизводимый файл
  @override
  Future<MediaItemUrl> loadEpisodeUrl(
      WidgetRef ref, MediaItemEpisode episode) async {
    if (episode.qualities.isNotEmpty) {
      final qualities = episode.qualities;
      if (quality.isEmpty || !qualities.contains(quality)) {
        quality = qualities.sorted((a, b) => compareNatural(a, b)).first;
      }
    }

    return MediaItemUrl(
      video: episode.videoFileUrl.replaceFirst('_%s.', '_$quality.'),
      subtitles: episode.subtitlesFileUrl,
    );
  }
}
