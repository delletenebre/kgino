
import 'package:json_annotation/json_annotation.dart';

part 'tskg_episode.g.dart';

@JsonSerializable()
class TskgEpisode {
  final int id;
  final String title;
  final String description;
  final String quality;
  final Duration duration;
  
  TskgEpisode({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.quality = '',
    required this.duration,
  });

  factory TskgEpisode.fromJson(Map<String, dynamic> json) =>
    _$TskgEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$TskgEpisodeToJson(this);
}
