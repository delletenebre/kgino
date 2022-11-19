// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ockg_trailer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OckgTrailer _$OckgTrailerFromJson(Map<String, dynamic> json) {
  return _OckgTrailer.fromJson(json);
}

/// @nodoc
mixin _$OckgTrailer {
  @IntConverter()
  int get width => throw _privateConstructorUsedError;
  @IntConverter()
  int get height => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get preview => throw _privateConstructorUsedError;
  String get video => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OckgTrailerCopyWith<OckgTrailer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OckgTrailerCopyWith<$Res> {
  factory $OckgTrailerCopyWith(
          OckgTrailer value, $Res Function(OckgTrailer) then) =
      _$OckgTrailerCopyWithImpl<$Res, OckgTrailer>;
  @useResult
  $Res call(
      {@IntConverter() int width,
      @IntConverter() int height,
      String name,
      String preview,
      String video});
}

/// @nodoc
class _$OckgTrailerCopyWithImpl<$Res, $Val extends OckgTrailer>
    implements $OckgTrailerCopyWith<$Res> {
  _$OckgTrailerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? name = null,
    Object? preview = null,
    Object? video = null,
  }) {
    return _then(_value.copyWith(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      preview: null == preview
          ? _value.preview
          : preview // ignore: cast_nullable_to_non_nullable
              as String,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OckgTrailerCopyWith<$Res>
    implements $OckgTrailerCopyWith<$Res> {
  factory _$$_OckgTrailerCopyWith(
          _$_OckgTrailer value, $Res Function(_$_OckgTrailer) then) =
      __$$_OckgTrailerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IntConverter() int width,
      @IntConverter() int height,
      String name,
      String preview,
      String video});
}

/// @nodoc
class __$$_OckgTrailerCopyWithImpl<$Res>
    extends _$OckgTrailerCopyWithImpl<$Res, _$_OckgTrailer>
    implements _$$_OckgTrailerCopyWith<$Res> {
  __$$_OckgTrailerCopyWithImpl(
      _$_OckgTrailer _value, $Res Function(_$_OckgTrailer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? name = null,
    Object? preview = null,
    Object? video = null,
  }) {
    return _then(_$_OckgTrailer(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      preview: null == preview
          ? _value.preview
          : preview // ignore: cast_nullable_to_non_nullable
              as String,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_OckgTrailer implements _OckgTrailer {
  const _$_OckgTrailer(
      {@IntConverter() this.width = 0,
      @IntConverter() this.height = 0,
      this.name = '',
      this.preview = '',
      this.video = ''});

  factory _$_OckgTrailer.fromJson(Map<String, dynamic> json) =>
      _$$_OckgTrailerFromJson(json);

  @override
  @JsonKey()
  @IntConverter()
  final int width;
  @override
  @JsonKey()
  @IntConverter()
  final int height;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String preview;
  @override
  @JsonKey()
  final String video;

  @override
  String toString() {
    return 'OckgTrailer(width: $width, height: $height, name: $name, preview: $preview, video: $video)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OckgTrailer &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.preview, preview) || other.preview == preview) &&
            (identical(other.video, video) || other.video == video));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, width, height, name, preview, video);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OckgTrailerCopyWith<_$_OckgTrailer> get copyWith =>
      __$$_OckgTrailerCopyWithImpl<_$_OckgTrailer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OckgTrailerToJson(
      this,
    );
  }
}

abstract class _OckgTrailer implements OckgTrailer {
  const factory _OckgTrailer(
      {@IntConverter() final int width,
      @IntConverter() final int height,
      final String name,
      final String preview,
      final String video}) = _$_OckgTrailer;

  factory _OckgTrailer.fromJson(Map<String, dynamic> json) =
      _$_OckgTrailer.fromJson;

  @override
  @IntConverter()
  int get width;
  @override
  @IntConverter()
  int get height;
  @override
  String get name;
  @override
  String get preview;
  @override
  String get video;
  @override
  @JsonKey(ignore: true)
  _$$_OckgTrailerCopyWith<_$_OckgTrailer> get copyWith =>
      throw _privateConstructorUsedError;
}
