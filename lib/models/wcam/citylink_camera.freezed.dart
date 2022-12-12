// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'citylink_camera.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CitylinkCamera _$CitylinkCameraFromJson(Map<String, dynamic> json) {
  return _CitylinkCamera.fromJson(json);
}

/// @nodoc
mixin _$CitylinkCamera {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get img => throw _privateConstructorUsedError;
  String get src => throw _privateConstructorUsedError;
  String get download => throw _privateConstructorUsedError;
  String get cityName => throw _privateConstructorUsedError;
  int get audio => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CitylinkCameraCopyWith<CitylinkCamera> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CitylinkCameraCopyWith<$Res> {
  factory $CitylinkCameraCopyWith(
          CitylinkCamera value, $Res Function(CitylinkCamera) then) =
      _$CitylinkCameraCopyWithImpl<$Res, CitylinkCamera>;
  @useResult
  $Res call(
      {int id,
      String name,
      String img,
      String src,
      String download,
      String cityName,
      int audio});
}

/// @nodoc
class _$CitylinkCameraCopyWithImpl<$Res, $Val extends CitylinkCamera>
    implements $CitylinkCameraCopyWith<$Res> {
  _$CitylinkCameraCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? img = null,
    Object? src = null,
    Object? download = null,
    Object? cityName = null,
    Object? audio = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      img: null == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String,
      src: null == src
          ? _value.src
          : src // ignore: cast_nullable_to_non_nullable
              as String,
      download: null == download
          ? _value.download
          : download // ignore: cast_nullable_to_non_nullable
              as String,
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
      audio: null == audio
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CitylinkCameraCopyWith<$Res>
    implements $CitylinkCameraCopyWith<$Res> {
  factory _$$_CitylinkCameraCopyWith(
          _$_CitylinkCamera value, $Res Function(_$_CitylinkCamera) then) =
      __$$_CitylinkCameraCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String img,
      String src,
      String download,
      String cityName,
      int audio});
}

/// @nodoc
class __$$_CitylinkCameraCopyWithImpl<$Res>
    extends _$CitylinkCameraCopyWithImpl<$Res, _$_CitylinkCamera>
    implements _$$_CitylinkCameraCopyWith<$Res> {
  __$$_CitylinkCameraCopyWithImpl(
      _$_CitylinkCamera _value, $Res Function(_$_CitylinkCamera) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? img = null,
    Object? src = null,
    Object? download = null,
    Object? cityName = null,
    Object? audio = null,
  }) {
    return _then(_$_CitylinkCamera(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      img: null == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String,
      src: null == src
          ? _value.src
          : src // ignore: cast_nullable_to_non_nullable
              as String,
      download: null == download
          ? _value.download
          : download // ignore: cast_nullable_to_non_nullable
              as String,
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
      audio: null == audio
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CitylinkCamera implements _CitylinkCamera {
  const _$_CitylinkCamera(
      {this.id = 0,
      this.name = '',
      this.img = '',
      this.src = '',
      this.download = '',
      this.cityName = '',
      this.audio = 0});

  factory _$_CitylinkCamera.fromJson(Map<String, dynamic> json) =>
      _$$_CitylinkCameraFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String img;
  @override
  @JsonKey()
  final String src;
  @override
  @JsonKey()
  final String download;
  @override
  @JsonKey()
  final String cityName;
  @override
  @JsonKey()
  final int audio;

  @override
  String toString() {
    return 'CitylinkCamera(id: $id, name: $name, img: $img, src: $src, download: $download, cityName: $cityName, audio: $audio)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CitylinkCamera &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.img, img) || other.img == img) &&
            (identical(other.src, src) || other.src == src) &&
            (identical(other.download, download) ||
                other.download == download) &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName) &&
            (identical(other.audio, audio) || other.audio == audio));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, img, src, download, cityName, audio);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CitylinkCameraCopyWith<_$_CitylinkCamera> get copyWith =>
      __$$_CitylinkCameraCopyWithImpl<_$_CitylinkCamera>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CitylinkCameraToJson(
      this,
    );
  }
}

abstract class _CitylinkCamera implements CitylinkCamera {
  const factory _CitylinkCamera(
      {final int id,
      final String name,
      final String img,
      final String src,
      final String download,
      final String cityName,
      final int audio}) = _$_CitylinkCamera;

  factory _CitylinkCamera.fromJson(Map<String, dynamic> json) =
      _$_CitylinkCamera.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get img;
  @override
  String get src;
  @override
  String get download;
  @override
  String get cityName;
  @override
  int get audio;
  @override
  @JsonKey(ignore: true)
  _$$_CitylinkCameraCopyWith<_$_CitylinkCamera> get copyWith =>
      throw _privateConstructorUsedError;
}
