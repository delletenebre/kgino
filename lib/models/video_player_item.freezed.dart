// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_player_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoPlayerItem _$VideoPlayerItemFromJson(Map<String, dynamic> json) {
  return _VideoPlayerItem.fromJson(json);
}

/// @nodoc
mixin _$VideoPlayerItem {
  String get videoUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  int get startTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoPlayerItemCopyWith<VideoPlayerItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoPlayerItemCopyWith<$Res> {
  factory $VideoPlayerItemCopyWith(
          VideoPlayerItem value, $Res Function(VideoPlayerItem) then) =
      _$VideoPlayerItemCopyWithImpl<$Res, VideoPlayerItem>;
  @useResult
  $Res call({String videoUrl, String title, String subtitle, int startTime});
}

/// @nodoc
class _$VideoPlayerItemCopyWithImpl<$Res, $Val extends VideoPlayerItem>
    implements $VideoPlayerItemCopyWith<$Res> {
  _$VideoPlayerItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoUrl = null,
    Object? title = null,
    Object? subtitle = null,
    Object? startTime = null,
  }) {
    return _then(_value.copyWith(
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VideoPlayerItemCopyWith<$Res>
    implements $VideoPlayerItemCopyWith<$Res> {
  factory _$$_VideoPlayerItemCopyWith(
          _$_VideoPlayerItem value, $Res Function(_$_VideoPlayerItem) then) =
      __$$_VideoPlayerItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String videoUrl, String title, String subtitle, int startTime});
}

/// @nodoc
class __$$_VideoPlayerItemCopyWithImpl<$Res>
    extends _$VideoPlayerItemCopyWithImpl<$Res, _$_VideoPlayerItem>
    implements _$$_VideoPlayerItemCopyWith<$Res> {
  __$$_VideoPlayerItemCopyWithImpl(
      _$_VideoPlayerItem _value, $Res Function(_$_VideoPlayerItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoUrl = null,
    Object? title = null,
    Object? subtitle = null,
    Object? startTime = null,
  }) {
    return _then(_$_VideoPlayerItem(
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VideoPlayerItem implements _VideoPlayerItem {
  const _$_VideoPlayerItem(
      {required this.videoUrl,
      required this.title,
      this.subtitle = '',
      this.startTime = 0});

  factory _$_VideoPlayerItem.fromJson(Map<String, dynamic> json) =>
      _$$_VideoPlayerItemFromJson(json);

  @override
  final String videoUrl;
  @override
  final String title;
  @override
  @JsonKey()
  final String subtitle;
  @override
  @JsonKey()
  final int startTime;

  @override
  String toString() {
    return 'VideoPlayerItem(videoUrl: $videoUrl, title: $title, subtitle: $subtitle, startTime: $startTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoPlayerItem &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, videoUrl, title, subtitle, startTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VideoPlayerItemCopyWith<_$_VideoPlayerItem> get copyWith =>
      __$$_VideoPlayerItemCopyWithImpl<_$_VideoPlayerItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoPlayerItemToJson(
      this,
    );
  }
}

abstract class _VideoPlayerItem implements VideoPlayerItem {
  const factory _VideoPlayerItem(
      {required final String videoUrl,
      required final String title,
      final String subtitle,
      final int startTime}) = _$_VideoPlayerItem;

  factory _VideoPlayerItem.fromJson(Map<String, dynamic> json) =
      _$_VideoPlayerItem.fromJson;

  @override
  String get videoUrl;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  int get startTime;
  @override
  @JsonKey(ignore: true)
  _$$_VideoPlayerItemCopyWith<_$_VideoPlayerItem> get copyWith =>
      throw _privateConstructorUsedError;
}
