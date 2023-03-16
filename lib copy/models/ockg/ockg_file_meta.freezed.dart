// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ockg_file_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OckgFileMeta _$OckgFileMetaFromJson(Map<String, dynamic> json) {
  return _OckgFileMeta.fromJson(json);
}

/// @nodoc
mixin _$OckgFileMeta {
  @IntConverter()
  int get playtimeSeconds => throw _privateConstructorUsedError;
  String get format => throw _privateConstructorUsedError;
  OckgFileMetaMedia get video => throw _privateConstructorUsedError;
  List<OckgFileMetaMedia> get audio => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OckgFileMetaCopyWith<OckgFileMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OckgFileMetaCopyWith<$Res> {
  factory $OckgFileMetaCopyWith(
          OckgFileMeta value, $Res Function(OckgFileMeta) then) =
      _$OckgFileMetaCopyWithImpl<$Res, OckgFileMeta>;
  @useResult
  $Res call(
      {@IntConverter() int playtimeSeconds,
      String format,
      OckgFileMetaMedia video,
      List<OckgFileMetaMedia> audio});

  $OckgFileMetaMediaCopyWith<$Res> get video;
}

/// @nodoc
class _$OckgFileMetaCopyWithImpl<$Res, $Val extends OckgFileMeta>
    implements $OckgFileMetaCopyWith<$Res> {
  _$OckgFileMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playtimeSeconds = null,
    Object? format = null,
    Object? video = null,
    Object? audio = null,
  }) {
    return _then(_value.copyWith(
      playtimeSeconds: null == playtimeSeconds
          ? _value.playtimeSeconds
          : playtimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as OckgFileMetaMedia,
      audio: null == audio
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as List<OckgFileMetaMedia>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OckgFileMetaMediaCopyWith<$Res> get video {
    return $OckgFileMetaMediaCopyWith<$Res>(_value.video, (value) {
      return _then(_value.copyWith(video: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OckgFileMetaCopyWith<$Res>
    implements $OckgFileMetaCopyWith<$Res> {
  factory _$$_OckgFileMetaCopyWith(
          _$_OckgFileMeta value, $Res Function(_$_OckgFileMeta) then) =
      __$$_OckgFileMetaCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IntConverter() int playtimeSeconds,
      String format,
      OckgFileMetaMedia video,
      List<OckgFileMetaMedia> audio});

  @override
  $OckgFileMetaMediaCopyWith<$Res> get video;
}

/// @nodoc
class __$$_OckgFileMetaCopyWithImpl<$Res>
    extends _$OckgFileMetaCopyWithImpl<$Res, _$_OckgFileMeta>
    implements _$$_OckgFileMetaCopyWith<$Res> {
  __$$_OckgFileMetaCopyWithImpl(
      _$_OckgFileMeta _value, $Res Function(_$_OckgFileMeta) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playtimeSeconds = null,
    Object? format = null,
    Object? video = null,
    Object? audio = null,
  }) {
    return _then(_$_OckgFileMeta(
      playtimeSeconds: null == playtimeSeconds
          ? _value.playtimeSeconds
          : playtimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as OckgFileMetaMedia,
      audio: null == audio
          ? _value._audio
          : audio // ignore: cast_nullable_to_non_nullable
              as List<OckgFileMetaMedia>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_OckgFileMeta implements _OckgFileMeta {
  const _$_OckgFileMeta(
      {@IntConverter() this.playtimeSeconds = 0,
      this.format = '',
      required this.video,
      required final List<OckgFileMetaMedia> audio})
      : _audio = audio;

  factory _$_OckgFileMeta.fromJson(Map<String, dynamic> json) =>
      _$$_OckgFileMetaFromJson(json);

  @override
  @JsonKey()
  @IntConverter()
  final int playtimeSeconds;
  @override
  @JsonKey()
  final String format;
  @override
  final OckgFileMetaMedia video;
  final List<OckgFileMetaMedia> _audio;
  @override
  List<OckgFileMetaMedia> get audio {
    if (_audio is EqualUnmodifiableListView) return _audio;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audio);
  }

  @override
  String toString() {
    return 'OckgFileMeta(playtimeSeconds: $playtimeSeconds, format: $format, video: $video, audio: $audio)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OckgFileMeta &&
            (identical(other.playtimeSeconds, playtimeSeconds) ||
                other.playtimeSeconds == playtimeSeconds) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.video, video) || other.video == video) &&
            const DeepCollectionEquality().equals(other._audio, _audio));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, playtimeSeconds, format, video,
      const DeepCollectionEquality().hash(_audio));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OckgFileMetaCopyWith<_$_OckgFileMeta> get copyWith =>
      __$$_OckgFileMetaCopyWithImpl<_$_OckgFileMeta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OckgFileMetaToJson(
      this,
    );
  }
}

abstract class _OckgFileMeta implements OckgFileMeta {
  const factory _OckgFileMeta(
      {@IntConverter() final int playtimeSeconds,
      final String format,
      required final OckgFileMetaMedia video,
      required final List<OckgFileMetaMedia> audio}) = _$_OckgFileMeta;

  factory _OckgFileMeta.fromJson(Map<String, dynamic> json) =
      _$_OckgFileMeta.fromJson;

  @override
  @IntConverter()
  int get playtimeSeconds;
  @override
  String get format;
  @override
  OckgFileMetaMedia get video;
  @override
  List<OckgFileMetaMedia> get audio;
  @override
  @JsonKey(ignore: true)
  _$$_OckgFileMetaCopyWith<_$_OckgFileMeta> get copyWith =>
      throw _privateConstructorUsedError;
}
