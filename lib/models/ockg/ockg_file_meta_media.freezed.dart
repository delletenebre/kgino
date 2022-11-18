// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ockg_file_meta_media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OckgFileMetaMedia _$OckgFileMetaMediaFromJson(Map<String, dynamic> json) {
  return _OckgFileMetaMedia.fromJson(json);
}

/// @nodoc
mixin _$OckgFileMetaMedia {
  String get label => throw _privateConstructorUsedError;
  String get info => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OckgFileMetaMediaCopyWith<OckgFileMetaMedia> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OckgFileMetaMediaCopyWith<$Res> {
  factory $OckgFileMetaMediaCopyWith(
          OckgFileMetaMedia value, $Res Function(OckgFileMetaMedia) then) =
      _$OckgFileMetaMediaCopyWithImpl<$Res, OckgFileMetaMedia>;
  @useResult
  $Res call({String label, String info});
}

/// @nodoc
class _$OckgFileMetaMediaCopyWithImpl<$Res, $Val extends OckgFileMetaMedia>
    implements $OckgFileMetaMediaCopyWith<$Res> {
  _$OckgFileMetaMediaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? info = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OckgFileMetaMediaCopyWith<$Res>
    implements $OckgFileMetaMediaCopyWith<$Res> {
  factory _$$_OckgFileMetaMediaCopyWith(_$_OckgFileMetaMedia value,
          $Res Function(_$_OckgFileMetaMedia) then) =
      __$$_OckgFileMetaMediaCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String info});
}

/// @nodoc
class __$$_OckgFileMetaMediaCopyWithImpl<$Res>
    extends _$OckgFileMetaMediaCopyWithImpl<$Res, _$_OckgFileMetaMedia>
    implements _$$_OckgFileMetaMediaCopyWith<$Res> {
  __$$_OckgFileMetaMediaCopyWithImpl(
      _$_OckgFileMetaMedia _value, $Res Function(_$_OckgFileMetaMedia) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? info = null,
  }) {
    return _then(_$_OckgFileMetaMedia(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_OckgFileMetaMedia implements _OckgFileMetaMedia {
  const _$_OckgFileMetaMedia({this.label = '', this.info = ''});

  factory _$_OckgFileMetaMedia.fromJson(Map<String, dynamic> json) =>
      _$$_OckgFileMetaMediaFromJson(json);

  @override
  @JsonKey()
  final String label;
  @override
  @JsonKey()
  final String info;

  @override
  String toString() {
    return 'OckgFileMetaMedia(label: $label, info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OckgFileMetaMedia &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.info, info) || other.info == info));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, label, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OckgFileMetaMediaCopyWith<_$_OckgFileMetaMedia> get copyWith =>
      __$$_OckgFileMetaMediaCopyWithImpl<_$_OckgFileMetaMedia>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OckgFileMetaMediaToJson(
      this,
    );
  }
}

abstract class _OckgFileMetaMedia implements OckgFileMetaMedia {
  const factory _OckgFileMetaMedia({final String label, final String info}) =
      _$_OckgFileMetaMedia;

  factory _OckgFileMetaMedia.fromJson(Map<String, dynamic> json) =
      _$_OckgFileMetaMedia.fromJson;

  @override
  String get label;
  @override
  String get info;
  @override
  @JsonKey(ignore: true)
  _$$_OckgFileMetaMediaCopyWith<_$_OckgFileMetaMedia> get copyWith =>
      throw _privateConstructorUsedError;
}
