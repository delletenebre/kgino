// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filmix_player_links.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FilmixPlayerLinks _$FilmixPlayerLinksFromJson(Map<String, dynamic> json) {
  return _FilmixPlayerLinks.fromJson(json);
}

/// @nodoc
mixin _$FilmixPlayerLinks {
  List<FilmixMovieLink> get movie => throw _privateConstructorUsedError;
  dynamic get playlist => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilmixPlayerLinksCopyWith<FilmixPlayerLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilmixPlayerLinksCopyWith<$Res> {
  factory $FilmixPlayerLinksCopyWith(
          FilmixPlayerLinks value, $Res Function(FilmixPlayerLinks) then) =
      _$FilmixPlayerLinksCopyWithImpl<$Res, FilmixPlayerLinks>;
  @useResult
  $Res call({List<FilmixMovieLink> movie, dynamic playlist});
}

/// @nodoc
class _$FilmixPlayerLinksCopyWithImpl<$Res, $Val extends FilmixPlayerLinks>
    implements $FilmixPlayerLinksCopyWith<$Res> {
  _$FilmixPlayerLinksCopyWithImpl(this._value, this._then);

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
              as List<FilmixMovieLink>,
      playlist: freezed == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FilmixPlayerLinksCopyWith<$Res>
    implements $FilmixPlayerLinksCopyWith<$Res> {
  factory _$$_FilmixPlayerLinksCopyWith(_$_FilmixPlayerLinks value,
          $Res Function(_$_FilmixPlayerLinks) then) =
      __$$_FilmixPlayerLinksCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FilmixMovieLink> movie, dynamic playlist});
}

/// @nodoc
class __$$_FilmixPlayerLinksCopyWithImpl<$Res>
    extends _$FilmixPlayerLinksCopyWithImpl<$Res, _$_FilmixPlayerLinks>
    implements _$$_FilmixPlayerLinksCopyWith<$Res> {
  __$$_FilmixPlayerLinksCopyWithImpl(
      _$_FilmixPlayerLinks _value, $Res Function(_$_FilmixPlayerLinks) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movie = null,
    Object? playlist = freezed,
  }) {
    return _then(_$_FilmixPlayerLinks(
      movie: null == movie
          ? _value._movie
          : movie // ignore: cast_nullable_to_non_nullable
              as List<FilmixMovieLink>,
      playlist: freezed == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FilmixPlayerLinks implements _FilmixPlayerLinks {
  const _$_FilmixPlayerLinks(
      {final List<FilmixMovieLink> movie = const [], this.playlist})
      : _movie = movie;

  factory _$_FilmixPlayerLinks.fromJson(Map<String, dynamic> json) =>
      _$$_FilmixPlayerLinksFromJson(json);

  final List<FilmixMovieLink> _movie;
  @override
  @JsonKey()
  List<FilmixMovieLink> get movie {
    if (_movie is EqualUnmodifiableListView) return _movie;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movie);
  }

  @override
  final dynamic playlist;

  @override
  String toString() {
    return 'FilmixPlayerLinks(movie: $movie, playlist: $playlist)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FilmixPlayerLinks &&
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
  _$$_FilmixPlayerLinksCopyWith<_$_FilmixPlayerLinks> get copyWith =>
      __$$_FilmixPlayerLinksCopyWithImpl<_$_FilmixPlayerLinks>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FilmixPlayerLinksToJson(
      this,
    );
  }
}

abstract class _FilmixPlayerLinks implements FilmixPlayerLinks {
  const factory _FilmixPlayerLinks(
      {final List<FilmixMovieLink> movie,
      final dynamic playlist}) = _$_FilmixPlayerLinks;

  factory _FilmixPlayerLinks.fromJson(Map<String, dynamic> json) =
      _$_FilmixPlayerLinks.fromJson;

  @override
  List<FilmixMovieLink> get movie;
  @override
  dynamic get playlist;
  @override
  @JsonKey(ignore: true)
  _$$_FilmixPlayerLinksCopyWith<_$_FilmixPlayerLinks> get copyWith =>
      throw _privateConstructorUsedError;
}
