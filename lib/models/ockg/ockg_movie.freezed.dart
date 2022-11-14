// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ockg_movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OckgMovie _$OckgMovieFromJson(Map<String, dynamic> json) {
  return _OckgMovie.fromJson(json);
}

/// @nodoc
mixin _$OckgMovie {
  String get movieId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get internationalName => throw _privateConstructorUsedError;
  String get year => throw _privateConstructorUsedError;
  String get cover => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OckgMovieCopyWith<OckgMovie> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OckgMovieCopyWith<$Res> {
  factory $OckgMovieCopyWith(OckgMovie value, $Res Function(OckgMovie) then) =
      _$OckgMovieCopyWithImpl<$Res, OckgMovie>;
  @useResult
  $Res call(
      {String movieId,
      String name,
      String internationalName,
      String year,
      String cover});
}

/// @nodoc
class _$OckgMovieCopyWithImpl<$Res, $Val extends OckgMovie>
    implements $OckgMovieCopyWith<$Res> {
  _$OckgMovieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movieId = null,
    Object? name = null,
    Object? internationalName = null,
    Object? year = null,
    Object? cover = null,
  }) {
    return _then(_value.copyWith(
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      internationalName: null == internationalName
          ? _value.internationalName
          : internationalName // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      cover: null == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OckgMovieCopyWith<$Res> implements $OckgMovieCopyWith<$Res> {
  factory _$$_OckgMovieCopyWith(
          _$_OckgMovie value, $Res Function(_$_OckgMovie) then) =
      __$$_OckgMovieCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String movieId,
      String name,
      String internationalName,
      String year,
      String cover});
}

/// @nodoc
class __$$_OckgMovieCopyWithImpl<$Res>
    extends _$OckgMovieCopyWithImpl<$Res, _$_OckgMovie>
    implements _$$_OckgMovieCopyWith<$Res> {
  __$$_OckgMovieCopyWithImpl(
      _$_OckgMovie _value, $Res Function(_$_OckgMovie) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movieId = null,
    Object? name = null,
    Object? internationalName = null,
    Object? year = null,
    Object? cover = null,
  }) {
    return _then(_$_OckgMovie(
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      internationalName: null == internationalName
          ? _value.internationalName
          : internationalName // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      cover: null == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_OckgMovie implements _OckgMovie {
  const _$_OckgMovie(
      {this.movieId = '',
      this.name = '',
      this.internationalName = '',
      this.year = '',
      this.cover = ''});

  factory _$_OckgMovie.fromJson(Map<String, dynamic> json) =>
      _$$_OckgMovieFromJson(json);

  @override
  @JsonKey()
  final String movieId;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String internationalName;
  @override
  @JsonKey()
  final String year;
  @override
  @JsonKey()
  final String cover;

  @override
  String toString() {
    return 'OckgMovie(movieId: $movieId, name: $name, internationalName: $internationalName, year: $year, cover: $cover)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OckgMovie &&
            (identical(other.movieId, movieId) || other.movieId == movieId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.internationalName, internationalName) ||
                other.internationalName == internationalName) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.cover, cover) || other.cover == cover));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, movieId, name, internationalName, year, cover);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OckgMovieCopyWith<_$_OckgMovie> get copyWith =>
      __$$_OckgMovieCopyWithImpl<_$_OckgMovie>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OckgMovieToJson(
      this,
    );
  }
}

abstract class _OckgMovie implements OckgMovie {
  const factory _OckgMovie(
      {final String movieId,
      final String name,
      final String internationalName,
      final String year,
      final String cover}) = _$_OckgMovie;

  factory _OckgMovie.fromJson(Map<String, dynamic> json) =
      _$_OckgMovie.fromJson;

  @override
  String get movieId;
  @override
  String get name;
  @override
  String get internationalName;
  @override
  String get year;
  @override
  String get cover;
  @override
  @JsonKey(ignore: true)
  _$$_OckgMovieCopyWith<_$_OckgMovie> get copyWith =>
      throw _privateConstructorUsedError;
}
