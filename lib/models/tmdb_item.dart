import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'tmdb_item.freezed.dart';
part 'tmdb_item.g.dart';

@freezed
class TmdbItem with _$TmdbItem {
  const TmdbItem._();

  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TmdbItem({
    String? title,
    String? name,
    @Default('') String overview,
    @Default('') String backdropPath,
    @Default('') String posterPath,
    String? firstAirDate,
  }) = _TmdbItem;

  factory TmdbItem.fromJson(Map<String, Object?> json) =>
      _$TmdbItemFromJson(json);

  String? get backdropImage => backdropPath.isNotEmpty
      ? 'https://image.tmdb.org/t/p/w500$backdropPath'
      : null;

  String get titleOrName => title ?? name ?? '';
}
