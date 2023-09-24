import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'voice_acting.freezed.dart';
part 'voice_acting.g.dart';

@Embedded(ignore: {'copyWith'})
@freezed
class VoiceActing with _$VoiceActing {
  const factory VoiceActing({
    @Default('') String id,
    @Default('') String name,
  }) = _VoiceActing;

  factory VoiceActing.fromJson(Map<String, Object?> json) =>
      _$VoiceActingFromJson(json);
}
