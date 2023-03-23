import 'package:freezed_annotation/freezed_annotation.dart';

part 'citylink_camera.freezed.dart';
part 'citylink_camera.g.dart';

@freezed
class CitylinkCamera with _$CitylinkCamera {

  const factory CitylinkCamera({
    
    @Default(0) int id,
    @Default('') String name,
    @Default('') String img,
    @Default('') String src,
    @Default('') String download,
    @Default('') String cityName,
    @Default(0) int audio,

  }) = _CitylinkCamera;

  factory CitylinkCamera.fromJson(Map<String, Object?> json)
      => _$CitylinkCameraFromJson(json);
}
