// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'playable_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlayableItem {
  String get id => throw _privateConstructorUsedError;
  String get videoUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get subtitleUrl => throw _privateConstructorUsedError;
  int get startTime => throw _privateConstructorUsedError;
  bool get subtitlesEnabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayableItemCopyWith<PlayableItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayableItemCopyWith<$Res> {
  factory $PlayableItemCopyWith(
          PlayableItem value, $Res Function(PlayableItem) then) =
      _$PlayableItemCopyWithImpl<$Res, PlayableItem>;
  @useResult
  $Res call(
      {String id,
      String videoUrl,
      String title,
      String subtitle,
      String subtitleUrl,
      int startTime,
      bool subtitlesEnabled});
}

/// @nodoc
class _$PlayableItemCopyWithImpl<$Res, $Val extends PlayableItem>
    implements $PlayableItemCopyWith<$Res> {
  _$PlayableItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? videoUrl = null,
    Object? title = null,
    Object? subtitle = null,
    Object? subtitleUrl = null,
    Object? startTime = null,
    Object? subtitlesEnabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      subtitleUrl: null == subtitleUrl
          ? _value.subtitleUrl
          : subtitleUrl // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int,
      subtitlesEnabled: null == subtitlesEnabled
          ? _value.subtitlesEnabled
          : subtitlesEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayableItemCopyWith<$Res>
    implements $PlayableItemCopyWith<$Res> {
  factory _$$_PlayableItemCopyWith(
          _$_PlayableItem value, $Res Function(_$_PlayableItem) then) =
      __$$_PlayableItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String videoUrl,
      String title,
      String subtitle,
      String subtitleUrl,
      int startTime,
      bool subtitlesEnabled});
}

/// @nodoc
class __$$_PlayableItemCopyWithImpl<$Res>
    extends _$PlayableItemCopyWithImpl<$Res, _$_PlayableItem>
    implements _$$_PlayableItemCopyWith<$Res> {
  __$$_PlayableItemCopyWithImpl(
      _$_PlayableItem _value, $Res Function(_$_PlayableItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? videoUrl = null,
    Object? title = null,
    Object? subtitle = null,
    Object? subtitleUrl = null,
    Object? startTime = null,
    Object? subtitlesEnabled = null,
  }) {
    return _then(_$_PlayableItem(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      subtitleUrl: null == subtitleUrl
          ? _value.subtitleUrl
          : subtitleUrl // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int,
      subtitlesEnabled: null == subtitlesEnabled
          ? _value.subtitlesEnabled
          : subtitlesEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PlayableItem implements _PlayableItem {
  const _$_PlayableItem(
      {required this.id,
      required this.videoUrl,
      required this.title,
      this.subtitle = '',
      this.subtitleUrl = '',
      this.startTime = 0,
      this.subtitlesEnabled = false});

  @override
  final String id;
  @override
  final String videoUrl;
  @override
  final String title;
  @override
  @JsonKey()
  final String subtitle;
  @override
  @JsonKey()
  final String subtitleUrl;
  @override
  @JsonKey()
  final int startTime;
  @override
  @JsonKey()
  final bool subtitlesEnabled;

  @override
  String toString() {
    return 'PlayableItem(id: $id, videoUrl: $videoUrl, title: $title, subtitle: $subtitle, subtitleUrl: $subtitleUrl, startTime: $startTime, subtitlesEnabled: $subtitlesEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayableItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.subtitleUrl, subtitleUrl) ||
                other.subtitleUrl == subtitleUrl) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.subtitlesEnabled, subtitlesEnabled) ||
                other.subtitlesEnabled == subtitlesEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, videoUrl, title, subtitle,
      subtitleUrl, startTime, subtitlesEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayableItemCopyWith<_$_PlayableItem> get copyWith =>
      __$$_PlayableItemCopyWithImpl<_$_PlayableItem>(this, _$identity);
}

abstract class _PlayableItem implements PlayableItem {
  const factory _PlayableItem(
      {required final String id,
      required final String videoUrl,
      required final String title,
      final String subtitle,
      final String subtitleUrl,
      final int startTime,
      final bool subtitlesEnabled}) = _$_PlayableItem;

  @override
  String get id;
  @override
  String get videoUrl;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get subtitleUrl;
  @override
  int get startTime;
  @override
  bool get subtitlesEnabled;
  @override
  @JsonKey(ignore: true)
  _$$_PlayableItemCopyWith<_$_PlayableItem> get copyWith =>
      throw _privateConstructorUsedError;
}
