import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'voice_acting.g.dart';

@JsonSerializable()
@embedded
class VoiceActing {
  final String id;
  final String name;

  const VoiceActing({
    this.id = '',
    this.name = '',
  });

  factory VoiceActing.fromJson(Map<String, dynamic> json) =>
      _$VoiceActingFromJson(json);

  Map<String, dynamic> toJson() => _$VoiceActingToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is VoiceActing && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);
}
