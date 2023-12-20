import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'voice_acting.freezed.dart';
part 'voice_acting.g.dart';

@freezed
@Embedded(ignore: {'copyWith'})
class VoiceActing with _$VoiceActing {
  const factory VoiceActing({
    @Default('') final String id,
    @Default('') final String name,
  }) = _VoiceActing;

  factory VoiceActing.fromJson(Map<String, dynamic> json) =>
      _$VoiceActingFromJson(json);
}
