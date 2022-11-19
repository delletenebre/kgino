
import 'package:json_annotation/json_annotation.dart';
import 'package:kgino/api/tskg/models/tskg_episode.dart';

part 'tskg_season.g.dart';

@JsonSerializable()
class TskgSeason {
  final String title;
  final List<TskgEpisode> episodes;
  
  TskgSeason({
    this.title = '',
    this.episodes = const [],
  });

  factory TskgSeason.fromJson(Map<String, dynamic> json) =>
    _$TskgSeasonFromJson(json);

  Map<String, dynamic> toJson() => _$TskgSeasonToJson(this);
}
