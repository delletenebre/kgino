import 'package:freezed_annotation/freezed_annotation.dart';

part 'flmx_last_episode.freezed.dart';
part 'flmx_last_episode.g.dart';

@freezed
class FlmxLastEpisode with _$FlmxLastEpisode {
  const factory FlmxLastEpisode({
    @Default('') String season,
    @Default('') String episode,
    @Default('') String translation,
  }) = _FlmxLastEpisode;

  factory FlmxLastEpisode.fromJson(Map<String, Object?> json)
      => _$FlmxLastEpisodeFromJson(json);
}
