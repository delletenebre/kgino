import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'media_item.freezed.dart';
part 'media_item.g.dart';

enum OnlineService {
  filmix,
  tskg,
}

@freezed
class MediaItem with _$MediaItem {
  const factory MediaItem({
    @Default('') String title,
    @Default('') String overview,
    @Default('') String posterUrl,
    @Default('') String backdropUrl,
    @Default([]) List<String> genres,
  }) = _MediaItem;

  factory MediaItem.fromJson(Map<String, Object?> json) =>
      _$MediaItemFromJson(json);
}

// abstract class MediaDetails {
//   int get population;
//   String get name;
// }