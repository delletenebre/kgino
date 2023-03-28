// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flmx_last_episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FlmxLastEpisode _$FlmxLastEpisodeFromJson(Map<String, dynamic> json) {
  return _FlmxLastEpisode.fromJson(json);
}

/// @nodoc
mixin _$FlmxLastEpisode {
  String get season => throw _privateConstructorUsedError;
  String get episode => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FlmxLastEpisodeCopyWith<FlmxLastEpisode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlmxLastEpisodeCopyWith<$Res> {
  factory $FlmxLastEpisodeCopyWith(
          FlmxLastEpisode value, $Res Function(FlmxLastEpisode) then) =
      _$FlmxLastEpisodeCopyWithImpl<$Res, FlmxLastEpisode>;
  @useResult
  $Res call({String season, String episode, String translation});
}

/// @nodoc
class _$FlmxLastEpisodeCopyWithImpl<$Res, $Val extends FlmxLastEpisode>
    implements $FlmxLastEpisodeCopyWith<$Res> {
  _$FlmxLastEpisodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? season = null,
    Object? episode = null,
    Object? translation = null,
  }) {
    return _then(_value.copyWith(
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String,
      episode: null == episode
          ? _value.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FlmxLastEpisodeCopyWith<$Res>
    implements $FlmxLastEpisodeCopyWith<$Res> {
  factory _$$_FlmxLastEpisodeCopyWith(
          _$_FlmxLastEpisode value, $Res Function(_$_FlmxLastEpisode) then) =
      __$$_FlmxLastEpisodeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String season, String episode, String translation});
}

/// @nodoc
class __$$_FlmxLastEpisodeCopyWithImpl<$Res>
    extends _$FlmxLastEpisodeCopyWithImpl<$Res, _$_FlmxLastEpisode>
    implements _$$_FlmxLastEpisodeCopyWith<$Res> {
  __$$_FlmxLastEpisodeCopyWithImpl(
      _$_FlmxLastEpisode _value, $Res Function(_$_FlmxLastEpisode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? season = null,
    Object? episode = null,
    Object? translation = null,
  }) {
    return _then(_$_FlmxLastEpisode(
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String,
      episode: null == episode
          ? _value.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FlmxLastEpisode implements _FlmxLastEpisode {
  const _$_FlmxLastEpisode(
      {this.season = '', this.episode = '', this.translation = ''});

  factory _$_FlmxLastEpisode.fromJson(Map<String, dynamic> json) =>
      _$$_FlmxLastEpisodeFromJson(json);

  @override
  @JsonKey()
  final String season;
  @override
  @JsonKey()
  final String episode;
  @override
  @JsonKey()
  final String translation;

  @override
  String toString() {
    return 'FlmxLastEpisode(season: $season, episode: $episode, translation: $translation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FlmxLastEpisode &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.episode, episode) || other.episode == episode) &&
            (identical(other.translation, translation) ||
                other.translation == translation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, season, episode, translation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FlmxLastEpisodeCopyWith<_$_FlmxLastEpisode> get copyWith =>
      __$$_FlmxLastEpisodeCopyWithImpl<_$_FlmxLastEpisode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FlmxLastEpisodeToJson(
      this,
    );
  }
}

abstract class _FlmxLastEpisode implements FlmxLastEpisode {
  const factory _FlmxLastEpisode(
      {final String season,
      final String episode,
      final String translation}) = _$_FlmxLastEpisode;

  factory _FlmxLastEpisode.fromJson(Map<String, dynamic> json) =
      _$_FlmxLastEpisode.fromJson;

  @override
  String get season;
  @override
  String get episode;
  @override
  String get translation;
  @override
  @JsonKey(ignore: true)
  _$$_FlmxLastEpisodeCopyWith<_$_FlmxLastEpisode> get copyWith =>
      throw _privateConstructorUsedError;
}
