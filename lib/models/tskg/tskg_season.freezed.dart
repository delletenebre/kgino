// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tskg_season.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TskgSeason {
  String get title => throw _privateConstructorUsedError;
  List<TskgEpisode> get episodes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TskgSeasonCopyWith<TskgSeason> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TskgSeasonCopyWith<$Res> {
  factory $TskgSeasonCopyWith(
          TskgSeason value, $Res Function(TskgSeason) then) =
      _$TskgSeasonCopyWithImpl<$Res, TskgSeason>;
  @useResult
  $Res call({String title, List<TskgEpisode> episodes});
}

/// @nodoc
class _$TskgSeasonCopyWithImpl<$Res, $Val extends TskgSeason>
    implements $TskgSeasonCopyWith<$Res> {
  _$TskgSeasonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? episodes = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<TskgEpisode>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TskgSeasonCopyWith<$Res>
    implements $TskgSeasonCopyWith<$Res> {
  factory _$$_TskgSeasonCopyWith(
          _$_TskgSeason value, $Res Function(_$_TskgSeason) then) =
      __$$_TskgSeasonCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<TskgEpisode> episodes});
}

/// @nodoc
class __$$_TskgSeasonCopyWithImpl<$Res>
    extends _$TskgSeasonCopyWithImpl<$Res, _$_TskgSeason>
    implements _$$_TskgSeasonCopyWith<$Res> {
  __$$_TskgSeasonCopyWithImpl(
      _$_TskgSeason _value, $Res Function(_$_TskgSeason) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? episodes = null,
  }) {
    return _then(_$_TskgSeason(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      episodes: null == episodes
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<TskgEpisode>,
    ));
  }
}

/// @nodoc

class _$_TskgSeason implements _TskgSeason {
  const _$_TskgSeason(
      {this.title = '', final List<TskgEpisode> episodes = const []})
      : _episodes = episodes;

  @override
  @JsonKey()
  final String title;
  final List<TskgEpisode> _episodes;
  @override
  @JsonKey()
  List<TskgEpisode> get episodes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  @override
  String toString() {
    return 'TskgSeason(title: $title, episodes: $episodes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TskgSeason &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, const DeepCollectionEquality().hash(_episodes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TskgSeasonCopyWith<_$_TskgSeason> get copyWith =>
      __$$_TskgSeasonCopyWithImpl<_$_TskgSeason>(this, _$identity);
}

abstract class _TskgSeason implements TskgSeason {
  const factory _TskgSeason(
      {final String title, final List<TskgEpisode> episodes}) = _$_TskgSeason;

  @override
  String get title;
  @override
  List<TskgEpisode> get episodes;
  @override
  @JsonKey(ignore: true)
  _$$_TskgSeasonCopyWith<_$_TskgSeason> get copyWith =>
      throw _privateConstructorUsedError;
}
