// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ockg_movie_cover.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OckgMovieCover _$OckgMovieCoverFromJson(Map<String, dynamic> json) {
  return _OckgMovieCover.fromJson(json);
}

/// @nodoc
mixin _$OckgMovieCover {
  String get original => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OckgMovieCoverCopyWith<OckgMovieCover> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OckgMovieCoverCopyWith<$Res> {
  factory $OckgMovieCoverCopyWith(
          OckgMovieCover value, $Res Function(OckgMovieCover) then) =
      _$OckgMovieCoverCopyWithImpl<$Res, OckgMovieCover>;
  @useResult
  $Res call({String original, String thumbnail});
}

/// @nodoc
class _$OckgMovieCoverCopyWithImpl<$Res, $Val extends OckgMovieCover>
    implements $OckgMovieCoverCopyWith<$Res> {
  _$OckgMovieCoverCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? thumbnail = null,
  }) {
    return _then(_value.copyWith(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OckgMovieCoverCopyWith<$Res>
    implements $OckgMovieCoverCopyWith<$Res> {
  factory _$$_OckgMovieCoverCopyWith(
          _$_OckgMovieCover value, $Res Function(_$_OckgMovieCover) then) =
      __$$_OckgMovieCoverCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String original, String thumbnail});
}

/// @nodoc
class __$$_OckgMovieCoverCopyWithImpl<$Res>
    extends _$OckgMovieCoverCopyWithImpl<$Res, _$_OckgMovieCover>
    implements _$$_OckgMovieCoverCopyWith<$Res> {
  __$$_OckgMovieCoverCopyWithImpl(
      _$_OckgMovieCover _value, $Res Function(_$_OckgMovieCover) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? thumbnail = null,
  }) {
    return _then(_$_OckgMovieCover(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_OckgMovieCover implements _OckgMovieCover {
  const _$_OckgMovieCover({this.original = '', this.thumbnail = ''});

  factory _$_OckgMovieCover.fromJson(Map<String, dynamic> json) =>
      _$$_OckgMovieCoverFromJson(json);

  @override
  @JsonKey()
  final String original;
  @override
  @JsonKey()
  final String thumbnail;

  @override
  String toString() {
    return 'OckgMovieCover(original: $original, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OckgMovieCover &&
            (identical(other.original, original) ||
                other.original == original) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, original, thumbnail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OckgMovieCoverCopyWith<_$_OckgMovieCover> get copyWith =>
      __$$_OckgMovieCoverCopyWithImpl<_$_OckgMovieCover>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OckgMovieCoverToJson(
      this,
    );
  }
}

abstract class _OckgMovieCover implements OckgMovieCover {
  const factory _OckgMovieCover(
      {final String original, final String thumbnail}) = _$_OckgMovieCover;

  factory _OckgMovieCover.fromJson(Map<String, dynamic> json) =
      _$_OckgMovieCover.fromJson;

  @override
  String get original;
  @override
  String get thumbnail;
  @override
  @JsonKey(ignore: true)
  _$$_OckgMovieCoverCopyWith<_$_OckgMovieCover> get copyWith =>
      throw _privateConstructorUsedError;
}
