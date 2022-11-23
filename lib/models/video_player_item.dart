import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_player_item.freezed.dart';
part 'video_player_item.g.dart';

@freezed
class VideoPlayerItem with _$VideoPlayerItem {
  const factory VideoPlayerItem({
    required String videoUrl,
    required String title,
    @Default('') String subtitle,
    @Default(0) int startTime,

  }) = _VideoPlayerItem;

  factory VideoPlayerItem.fromJson(Map<String, Object?> json)
      => _$VideoPlayerItemFromJson(json);
}
