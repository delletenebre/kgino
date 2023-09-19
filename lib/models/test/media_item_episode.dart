import 'package:json_annotation/json_annotation.dart';

import '../../extensions/json_converters.dart';

part 'media_item_episode.g.dart';

@JsonSerializable()
class MediaItemEpisode {
  @StringConverter()
  final String id;
  final String videoFileUrl;
  final List<int> qualities;

  MediaItemEpisode({
    this.id = '',
    this.videoFileUrl = '',
    this.qualities = const [],
  });

  factory MediaItemEpisode.fromJson(Map<String, dynamic> json) =>
      _$MediaItemEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemEpisodeToJson(this);
}
