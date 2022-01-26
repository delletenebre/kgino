
import 'package:json_annotation/json_annotation.dart';

part 'tskg_episode.g.dart';

@JsonSerializable()
class TskgEpisode {
  final String id;
  final String title;
  final String description;
  final String quality;
  final Duration duration;
  
  TskgEpisode({
    this.id = '',
    this.title = '',
    this.description = '',
    this.quality = '',
    this.duration = Duration.zero,
  });

  factory TskgEpisode.fromJson(Map<String, dynamic> json) =>
    _$TskgEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$TskgEpisodeToJson(this);
}
