import 'package:freezed_annotation/freezed_annotation.dart';

part 'playable_item.freezed.dart';

@freezed
class PlayableItem with _$PlayableItem {
  const factory PlayableItem({
    required String id,
    required String videoUrl,
    required String title,
    @Default('') String subtitle,
    @Default('') String subtitleUrl,
    @Default(0) int startTime,

  }) = _PlayableItem;
}
