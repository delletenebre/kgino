import 'package:freezed_annotation/freezed_annotation.dart';

part 'playable_item.freezed.dart';
part 'playable_item.g.dart';

@freezed
class PlayableItem with _$PlayableItem {
  const factory PlayableItem({
    required String videoUrl,
    required String title,
    @Default('') String subtitle,
    @Default(0) int startTime,

  }) = _PlayableItem;

  factory PlayableItem.fromJson(Map<String, Object?> json)
      => _$PlayableItemFromJson(json);
}
