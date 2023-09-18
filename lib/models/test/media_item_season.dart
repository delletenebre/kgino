import 'package:json_annotation/json_annotation.dart';

import '../../extensions/json_converters.dart';
import 'media_item_episode.dart';

part 'media_item_season.g.dart';

@JsonSerializable()
class MediaItemSeason {
  @StringConverter()
  final String id;
  final List<MediaItemEpisode> episodes;

  MediaItemSeason({
    this.id = '',
    this.episodes = const [],
  });

  factory MediaItemSeason.fromJson(Map<String, dynamic> json) =>
      _$MediaItemSeasonFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemSeasonToJson(this);
}
