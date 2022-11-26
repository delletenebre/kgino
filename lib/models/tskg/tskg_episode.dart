import 'package:freezed_annotation/freezed_annotation.dart';

part 'tskg_episode.freezed.dart';
part 'tskg_episode.g.dart';

@freezed
class TskgEpisode with _$TskgEpisode {
  const factory TskgEpisode({
    @Default(0) int id,
    @Default('') String showId,
    @Default('') String title,
    @Default('') String description,
    @Default('') String quality,
    @Default(Duration.zero) Duration duration,
    
  }) = _TskgEpisode;

  factory TskgEpisode.fromJson(Map<String, Object?> json)
      => _$TskgEpisodeFromJson(json);
}
