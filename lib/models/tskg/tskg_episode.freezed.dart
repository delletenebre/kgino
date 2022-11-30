// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tskg_episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TskgEpisode {
  int get id => throw _privateConstructorUsedError;
  String get showId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get quality => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TskgEpisodeCopyWith<TskgEpisode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TskgEpisodeCopyWith<$Res> {
  factory $TskgEpisodeCopyWith(
          TskgEpisode value, $Res Function(TskgEpisode) then) =
      _$TskgEpisodeCopyWithImpl<$Res, TskgEpisode>;
  @useResult
  $Res call(
      {int id,
      String showId,
      String title,
      String description,
      String quality,
      Duration duration});
}

/// @nodoc
class _$TskgEpisodeCopyWithImpl<$Res, $Val extends TskgEpisode>
    implements $TskgEpisodeCopyWith<$Res> {
  _$TskgEpisodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? showId = null,
    Object? title = null,
    Object? description = null,
    Object? quality = null,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      showId: null == showId
          ? _value.showId
          : showId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TskgEpisodeCopyWith<$Res>
    implements $TskgEpisodeCopyWith<$Res> {
  factory _$$_TskgEpisodeCopyWith(
          _$_TskgEpisode value, $Res Function(_$_TskgEpisode) then) =
      __$$_TskgEpisodeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String showId,
      String title,
      String description,
      String quality,
      Duration duration});
}

/// @nodoc
class __$$_TskgEpisodeCopyWithImpl<$Res>
    extends _$TskgEpisodeCopyWithImpl<$Res, _$_TskgEpisode>
    implements _$$_TskgEpisodeCopyWith<$Res> {
  __$$_TskgEpisodeCopyWithImpl(
      _$_TskgEpisode _value, $Res Function(_$_TskgEpisode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? showId = null,
    Object? title = null,
    Object? description = null,
    Object? quality = null,
    Object? duration = null,
  }) {
    return _then(_$_TskgEpisode(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      showId: null == showId
          ? _value.showId
          : showId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$_TskgEpisode implements _TskgEpisode {
  const _$_TskgEpisode(
      {this.id = 0,
      this.showId = '',
      this.title = '',
      this.description = '',
      this.quality = '',
      this.duration = Duration.zero});

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String showId;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String quality;
  @override
  @JsonKey()
  final Duration duration;

  @override
  String toString() {
    return 'TskgEpisode(id: $id, showId: $showId, title: $title, description: $description, quality: $quality, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TskgEpisode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.showId, showId) || other.showId == showId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, showId, title, description, quality, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TskgEpisodeCopyWith<_$_TskgEpisode> get copyWith =>
      __$$_TskgEpisodeCopyWithImpl<_$_TskgEpisode>(this, _$identity);
}

abstract class _TskgEpisode implements TskgEpisode {
  const factory _TskgEpisode(
      {final int id,
      final String showId,
      final String title,
      final String description,
      final String quality,
      final Duration duration}) = _$_TskgEpisode;

  @override
  int get id;
  @override
  String get showId;
  @override
  String get title;
  @override
  String get description;
  @override
  String get quality;
  @override
  Duration get duration;
  @override
  @JsonKey(ignore: true)
  _$$_TskgEpisodeCopyWith<_$_TskgEpisode> get copyWith =>
      throw _privateConstructorUsedError;
}
