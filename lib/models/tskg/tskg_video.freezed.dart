// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tskg_video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TskgVideo _$TskgVideoFromJson(Map<String, dynamic> json) {
  return _TskgVideo.fromJson(json);
}

/// @nodoc
mixin _$TskgVideo {
// @JsonKey(name: 'HD') @Default(false) bool hd,
// required TskgVideoFiles files,
  String get mimetype => throw _privateConstructorUsedError;
  String get videotype => throw _privateConstructorUsedError;
  String get subtitles => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TskgVideoCopyWith<TskgVideo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TskgVideoCopyWith<$Res> {
  factory $TskgVideoCopyWith(TskgVideo value, $Res Function(TskgVideo) then) =
      _$TskgVideoCopyWithImpl<$Res, TskgVideo>;
  @useResult
  $Res call({String mimetype, String videotype, String subtitles, String url});
}

/// @nodoc
class _$TskgVideoCopyWithImpl<$Res, $Val extends TskgVideo>
    implements $TskgVideoCopyWith<$Res> {
  _$TskgVideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mimetype = null,
    Object? videotype = null,
    Object? subtitles = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      mimetype: null == mimetype
          ? _value.mimetype
          : mimetype // ignore: cast_nullable_to_non_nullable
              as String,
      videotype: null == videotype
          ? _value.videotype
          : videotype // ignore: cast_nullable_to_non_nullable
              as String,
      subtitles: null == subtitles
          ? _value.subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TskgVideoCopyWith<$Res> implements $TskgVideoCopyWith<$Res> {
  factory _$$_TskgVideoCopyWith(
          _$_TskgVideo value, $Res Function(_$_TskgVideo) then) =
      __$$_TskgVideoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mimetype, String videotype, String subtitles, String url});
}

/// @nodoc
class __$$_TskgVideoCopyWithImpl<$Res>
    extends _$TskgVideoCopyWithImpl<$Res, _$_TskgVideo>
    implements _$$_TskgVideoCopyWith<$Res> {
  __$$_TskgVideoCopyWithImpl(
      _$_TskgVideo _value, $Res Function(_$_TskgVideo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mimetype = null,
    Object? videotype = null,
    Object? subtitles = null,
    Object? url = null,
  }) {
    return _then(_$_TskgVideo(
      mimetype: null == mimetype
          ? _value.mimetype
          : mimetype // ignore: cast_nullable_to_non_nullable
              as String,
      videotype: null == videotype
          ? _value.videotype
          : videotype // ignore: cast_nullable_to_non_nullable
              as String,
      subtitles: null == subtitles
          ? _value.subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TskgVideo implements _TskgVideo {
  const _$_TskgVideo(
      {this.mimetype = '',
      this.videotype = '',
      this.subtitles = '',
      required this.url});

  factory _$_TskgVideo.fromJson(Map<String, dynamic> json) =>
      _$$_TskgVideoFromJson(json);

// @JsonKey(name: 'HD') @Default(false) bool hd,
// required TskgVideoFiles files,
  @override
  @JsonKey()
  final String mimetype;
  @override
  @JsonKey()
  final String videotype;
  @override
  @JsonKey()
  final String subtitles;
  @override
  final String url;

  @override
  String toString() {
    return 'TskgVideo(mimetype: $mimetype, videotype: $videotype, subtitles: $subtitles, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TskgVideo &&
            (identical(other.mimetype, mimetype) ||
                other.mimetype == mimetype) &&
            (identical(other.videotype, videotype) ||
                other.videotype == videotype) &&
            (identical(other.subtitles, subtitles) ||
                other.subtitles == subtitles) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, mimetype, videotype, subtitles, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TskgVideoCopyWith<_$_TskgVideo> get copyWith =>
      __$$_TskgVideoCopyWithImpl<_$_TskgVideo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TskgVideoToJson(
      this,
    );
  }
}

abstract class _TskgVideo implements TskgVideo {
  const factory _TskgVideo(
      {final String mimetype,
      final String videotype,
      final String subtitles,
      required final String url}) = _$_TskgVideo;

  factory _TskgVideo.fromJson(Map<String, dynamic> json) =
      _$_TskgVideo.fromJson;

  @override // @JsonKey(name: 'HD') @Default(false) bool hd,
// required TskgVideoFiles files,
  String get mimetype;
  @override
  String get videotype;
  @override
  String get subtitles;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$_TskgVideoCopyWith<_$_TskgVideo> get copyWith =>
      throw _privateConstructorUsedError;
}
