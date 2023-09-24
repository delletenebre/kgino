import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../extensions/json_converters.dart';

part 'media_item_episode.g.dart';

@JsonSerializable()
@embedded
class MediaItemEpisode {
  @StringConverter()
  final String id;
  final String name;
  final int seasonNumber;
  final int episodeNumber;
  final String videoFileUrl;
  final List<int> qualities;

  MediaItemEpisode({
    this.id = '',
    this.name = '',
    this.seasonNumber = 0,
    this.episodeNumber = 0,
    this.videoFileUrl = '',
    this.qualities = const [],
  });

  factory MediaItemEpisode.fromJson(Map<String, dynamic> json) =>
      _$MediaItemEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemEpisodeToJson(this);
}
