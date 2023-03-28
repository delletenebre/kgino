// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flmx_player_links.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FlmxPlayerLinks _$FlmxPlayerLinksFromJson(Map<String, dynamic> json) {
  return _FlmxPlayerLinks.fromJson(json);
}

/// @nodoc
mixin _$FlmxPlayerLinks {
  List<FlmxMovieLink> get movie => throw _privateConstructorUsedError;
  dynamic get playlist => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FlmxPlayerLinksCopyWith<FlmxPlayerLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlmxPlayerLinksCopyWith<$Res> {
  factory $FlmxPlayerLinksCopyWith(
          FlmxPlayerLinks value, $Res Function(FlmxPlayerLinks) then) =
      _$FlmxPlayerLinksCopyWithImpl<$Res, FlmxPlayerLinks>;
  @useResult
  $Res call({List<FlmxMovieLink> movie, dynamic playlist});
}

/// @nodoc
class _$FlmxPlayerLinksCopyWithImpl<$Res, $Val extends FlmxPlayerLinks>
    implements $FlmxPlayerLinksCopyWith<$Res> {
  _$FlmxPlayerLinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movie = null,
    Object? playlist = freezed,
  }) {
    return _then(_value.copyWith(
      movie: null == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as List<FlmxMovieLink>,
      playlist: freezed == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FlmxPlayerLinksCopyWith<$Res>
    implements $FlmxPlayerLinksCopyWith<$Res> {
  factory _$$_FlmxPlayerLinksCopyWith(
          _$_FlmxPlayerLinks value, $Res Function(_$_FlmxPlayerLinks) then) =
      __$$_FlmxPlayerLinksCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FlmxMovieLink> movie, dynamic playlist});
}

/// @nodoc
class __$$_FlmxPlayerLinksCopyWithImpl<$Res>
    extends _$FlmxPlayerLinksCopyWithImpl<$Res, _$_FlmxPlayerLinks>
    implements _$$_FlmxPlayerLinksCopyWith<$Res> {
  __$$_FlmxPlayerLinksCopyWithImpl(
      _$_FlmxPlayerLinks _value, $Res Function(_$_FlmxPlayerLinks) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movie = null,
    Object? playlist = freezed,
  }) {
    return _then(_$_FlmxPlayerLinks(
      movie: null == movie
          ? _value._movie
          : movie // ignore: cast_nullable_to_non_nullable
              as List<FlmxMovieLink>,
      playlist: freezed == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FlmxPlayerLinks implements _FlmxPlayerLinks {
  const _$_FlmxPlayerLinks(
      {final List<FlmxMovieLink> movie = const [], this.playlist})
      : _movie = movie;

  factory _$_FlmxPlayerLinks.fromJson(Map<String, dynamic> json) =>
      _$$_FlmxPlayerLinksFromJson(json);

  final List<FlmxMovieLink> _movie;
  @override
  @JsonKey()
  List<FlmxMovieLink> get movie {
    if (_movie is EqualUnmodifiableListView) return _movie;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movie);
  }

  @override
  final dynamic playlist;

  @override
  String toString() {
    return 'FlmxPlayerLinks(movie: $movie, playlist: $playlist)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FlmxPlayerLinks &&
            const DeepCollectionEquality().equals(other._movie, _movie) &&
            const DeepCollectionEquality().equals(other.playlist, playlist));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_movie),
      const DeepCollectionEquality().hash(playlist));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FlmxPlayerLinksCopyWith<_$_FlmxPlayerLinks> get copyWith =>
      __$$_FlmxPlayerLinksCopyWithImpl<_$_FlmxPlayerLinks>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FlmxPlayerLinksToJson(
      this,
    );
  }
}

abstract class _FlmxPlayerLinks implements FlmxPlayerLinks {
  const factory _FlmxPlayerLinks(
      {final List<FlmxMovieLink> movie,
      final dynamic playlist}) = _$_FlmxPlayerLinks;

  factory _FlmxPlayerLinks.fromJson(Map<String, dynamic> json) =
      _$_FlmxPlayerLinks.fromJson;

  @override
  List<FlmxMovieLink> get movie;
  @override
  dynamic get playlist;
  @override
  @JsonKey(ignore: true)
  _$$_FlmxPlayerLinksCopyWith<_$_FlmxPlayerLinks> get copyWith =>
      throw _privateConstructorUsedError;
}
