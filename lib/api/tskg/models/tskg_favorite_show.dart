import 'package:json_annotation/json_annotation.dart';

part 'tskg_favorite_show.g.dart';

@JsonSerializable()
class TskgFavoriteShow {
  final String id;
  final String title;
  final int episodesCount;
  
  TskgFavoriteShow(
    this.id,
    this.title,
    this.episodesCount,
  );

  factory TskgFavoriteShow.fromJson(Map<String, dynamic> json) =>
    _$TskgFavoriteShowFromJson(json);

  Map<String, dynamic> toJson() => _$TskgFavoriteShowToJson(this);
}
