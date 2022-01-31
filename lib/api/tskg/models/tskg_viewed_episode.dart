import 'package:json_annotation/json_annotation.dart';

part 'tskg_viewed_episode.g.dart';

@JsonSerializable()
class TskgViewedEpisode {
  final String showId;
  final int episodeId;
  final int position;
  final int viewTimestamp;
  
  TskgViewedEpisode({
    required this.showId,
    required this.episodeId,
    required this.position,
    required this.viewTimestamp,
  });

  factory TskgViewedEpisode.fromJson(Map<String, dynamic> json) =>
    _$TskgViewedEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$TskgViewedEpisodeToJson(this);
}
