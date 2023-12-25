import 'package:freezed_annotation/freezed_annotation.dart';

import 'media_item_episode.dart';

part 'media_item_season.freezed.dart';
part 'media_item_season.g.dart';

@freezed
class MediaItemSeason with _$MediaItemSeason {
  const MediaItemSeason._();

  const factory MediaItemSeason({
    @Default('') String id,
    @Default('') String name,
    @Default(<MediaItemEpisode>[]) List<MediaItemEpisode> episodes,
  }) = _MediaItemSeason;

  factory MediaItemSeason.fromJson(Map<String, dynamic> json) =>
      _$MediaItemSeasonFromJson(json);

  String nameOr(String name) {
    if (this.name.toLowerCase().startsWith('сезон')) {
      return this.name;
    }

    return name;
  }

  // @StringConverter()
  // final String id;
  // final String name;
  // final List<MediaItemEpisode> episodes;
  //
  // MediaItemSeason({
  //   this.id = '',
  //   this.name = '',
  //   this.episodes = const [],
  // });
  //
  // factory MediaItemSeason.fromJson(Map<String, dynamic> json) =>
  //     _$MediaItemSeasonFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$MediaItemSeasonToJson(this);
}
