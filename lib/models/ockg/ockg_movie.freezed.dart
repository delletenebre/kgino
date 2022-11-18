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
  @IntConverter()
  int get movieId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get internationalName => throw _privateConstructorUsedError;
  String get year => throw _privateConstructorUsedError;
  String get cover => throw _privateConstructorUsedError;
  @HtmlRemoveConverter()
  String get description => throw _privateConstructorUsedError;
  List<String> get translation => throw _privateConstructorUsedError;
  String get quality => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;
  List<String> get countries => throw _privateConstructorUsedError;
  List<String> get directors =>
      throw _privateConstructorUsedError; // @DoubleConverter()
// @Default(0.0) double ratingLocalValue,
  @DoubleConverter()
  double get ratingImdbValue => throw _privateConstructorUsedError;
  @DoubleConverter()
  double get ratingKinopoiskValue => throw _privateConstructorUsedError;
  List<OckgMovie> get otherMovies => throw _privateConstructorUsedError;

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
      {@IntConverter() int movieId,
      String name,
      String internationalName,
      String year,
      String cover,
      @HtmlRemoveConverter() String description,
      List<String> translation,
      String quality,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<String> genres,
      List<String> countries,
      List<String> directors,
      @DoubleConverter() double ratingImdbValue,
      @DoubleConverter() double ratingKinopoiskValue,
      List<OckgMovie> otherMovies});
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
    Object? description = null,
    Object? translation = null,
    Object? quality = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? genres = null,
    Object? countries = null,
    Object? directors = null,
    Object? ratingImdbValue = null,
    Object? ratingKinopoiskValue = null,
    Object? otherMovies = null,
  }) {
    return _then(_value.copyWith(
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as int,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
      directors: null == directors
          ? _value.directors
          : directors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      ratingImdbValue: null == ratingImdbValue
          ? _value.ratingImdbValue
          : ratingImdbValue // ignore: cast_nullable_to_non_nullable
              as double,
      ratingKinopoiskValue: null == ratingKinopoiskValue
          ? _value.ratingKinopoiskValue
          : ratingKinopoiskValue // ignore: cast_nullable_to_non_nullable
              as double,
      otherMovies: null == otherMovies
          ? _value.otherMovies
          : otherMovies // ignore: cast_nullable_to_non_nullable
              as List<OckgMovie>,
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
      {@IntConverter() int movieId,
      String name,
      String internationalName,
      String year,
      String cover,
      @HtmlRemoveConverter() String description,
      List<String> translation,
      String quality,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<String> genres,
      List<String> countries,
      List<String> directors,
      @DoubleConverter() double ratingImdbValue,
      @DoubleConverter() double ratingKinopoiskValue,
      List<OckgMovie> otherMovies});
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
    Object? description = null,
    Object? translation = null,
    Object? quality = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? genres = null,
    Object? countries = null,
    Object? directors = null,
    Object? ratingImdbValue = null,
    Object? ratingKinopoiskValue = null,
    Object? otherMovies = null,
  }) {
    return _then(_$_OckgMovie(
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as int,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value._translation
          : translation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      countries: null == countries
          ? _value._countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
      directors: null == directors
          ? _value._directors
          : directors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      ratingImdbValue: null == ratingImdbValue
          ? _value.ratingImdbValue
          : ratingImdbValue // ignore: cast_nullable_to_non_nullable
              as double,
      ratingKinopoiskValue: null == ratingKinopoiskValue
          ? _value.ratingKinopoiskValue
          : ratingKinopoiskValue // ignore: cast_nullable_to_non_nullable
              as double,
      otherMovies: null == otherMovies
          ? _value._otherMovies
          : otherMovies // ignore: cast_nullable_to_non_nullable
              as List<OckgMovie>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_OckgMovie extends _OckgMovie {
  const _$_OckgMovie(
      {@IntConverter() this.movieId = 0,
      this.name = '',
      this.internationalName = '',
      this.year = '',
      this.cover = '',
      @HtmlRemoveConverter() this.description = '',
      final List<String> translation = const [],
      this.quality = '',
      this.createdAt,
      this.updatedAt,
      final List<String> genres = const [],
      final List<String> countries = const [],
      final List<String> directors = const [],
      @DoubleConverter() this.ratingImdbValue = 0.0,
      @DoubleConverter() this.ratingKinopoiskValue = 0.0,
      final List<OckgMovie> otherMovies = const []})
      : _translation = translation,
        _genres = genres,
        _countries = countries,
        _directors = directors,
        _otherMovies = otherMovies,
        super._();

  factory _$_OckgMovie.fromJson(Map<String, dynamic> json) =>
      _$$_OckgMovieFromJson(json);

  @override
  @JsonKey()
  @IntConverter()
  final int movieId;
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
  @JsonKey()
  @HtmlRemoveConverter()
  final String description;
  final List<String> _translation;
  @override
  @JsonKey()
  List<String> get translation {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_translation);
  }

  @override
  @JsonKey()
  final String quality;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final List<String> _genres;
  @override
  @JsonKey()
  List<String> get genres {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  final List<String> _countries;
  @override
  @JsonKey()
  List<String> get countries {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_countries);
  }

  final List<String> _directors;
  @override
  @JsonKey()
  List<String> get directors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_directors);
  }

// @DoubleConverter()
// @Default(0.0) double ratingLocalValue,
  @override
  @JsonKey()
  @DoubleConverter()
  final double ratingImdbValue;
  @override
  @JsonKey()
  @DoubleConverter()
  final double ratingKinopoiskValue;
  final List<OckgMovie> _otherMovies;
  @override
  @JsonKey()
  List<OckgMovie> get otherMovies {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_otherMovies);
  }

  @override
  String toString() {
    return 'OckgMovie(movieId: $movieId, name: $name, internationalName: $internationalName, year: $year, cover: $cover, description: $description, translation: $translation, quality: $quality, createdAt: $createdAt, updatedAt: $updatedAt, genres: $genres, countries: $countries, directors: $directors, ratingImdbValue: $ratingImdbValue, ratingKinopoiskValue: $ratingKinopoiskValue, otherMovies: $otherMovies)';
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
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._translation, _translation) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            const DeepCollectionEquality()
                .equals(other._countries, _countries) &&
            const DeepCollectionEquality()
                .equals(other._directors, _directors) &&
            (identical(other.ratingImdbValue, ratingImdbValue) ||
                other.ratingImdbValue == ratingImdbValue) &&
            (identical(other.ratingKinopoiskValue, ratingKinopoiskValue) ||
                other.ratingKinopoiskValue == ratingKinopoiskValue) &&
            const DeepCollectionEquality()
                .equals(other._otherMovies, _otherMovies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      movieId,
      name,
      internationalName,
      year,
      cover,
      description,
      const DeepCollectionEquality().hash(_translation),
      quality,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_genres),
      const DeepCollectionEquality().hash(_countries),
      const DeepCollectionEquality().hash(_directors),
      ratingImdbValue,
      ratingKinopoiskValue,
      const DeepCollectionEquality().hash(_otherMovies));

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

abstract class _OckgMovie extends OckgMovie {
  const factory _OckgMovie(
      {@IntConverter() final int movieId,
      final String name,
      final String internationalName,
      final String year,
      final String cover,
      @HtmlRemoveConverter() final String description,
      final List<String> translation,
      final String quality,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final List<String> genres,
      final List<String> countries,
      final List<String> directors,
      @DoubleConverter() final double ratingImdbValue,
      @DoubleConverter() final double ratingKinopoiskValue,
      final List<OckgMovie> otherMovies}) = _$_OckgMovie;
  const _OckgMovie._() : super._();

  factory _OckgMovie.fromJson(Map<String, dynamic> json) =
      _$_OckgMovie.fromJson;

  @override
  @IntConverter()
  int get movieId;
  @override
  String get name;
  @override
  String get internationalName;
  @override
  String get year;
  @override
  String get cover;
  @override
  @HtmlRemoveConverter()
  String get description;
  @override
  List<String> get translation;
  @override
  String get quality;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<String> get genres;
  @override
  List<String> get countries;
  @override
  List<String> get directors;
  @override // @DoubleConverter()
// @Default(0.0) double ratingLocalValue,
  @DoubleConverter()
  double get ratingImdbValue;
  @override
  @DoubleConverter()
  double get ratingKinopoiskValue;
  @override
  List<OckgMovie> get otherMovies;
  @override
  @JsonKey(ignore: true)
  _$$_OckgMovieCopyWith<_$_OckgMovie> get copyWith =>
      throw _privateConstructorUsedError;
}
