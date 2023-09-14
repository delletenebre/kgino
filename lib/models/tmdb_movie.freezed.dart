// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tmdb_movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TmdbMovie _$TmdbMovieFromJson(Map<String, dynamic> json) {
  return _TmdbMovie.fromJson(json);
}

/// @nodoc
mixin _$TmdbMovie {
  String get name => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  String get backdropPath => throw _privateConstructorUsedError;
  String get posterPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TmdbMovieCopyWith<TmdbMovie> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TmdbMovieCopyWith<$Res> {
  factory $TmdbMovieCopyWith(TmdbMovie value, $Res Function(TmdbMovie) then) =
      _$TmdbMovieCopyWithImpl<$Res, TmdbMovie>;
  @useResult
  $Res call(
      {String name, String overview, String backdropPath, String posterPath});
}

/// @nodoc
class _$TmdbMovieCopyWithImpl<$Res, $Val extends TmdbMovie>
    implements $TmdbMovieCopyWith<$Res> {
  _$TmdbMovieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? overview = null,
    Object? backdropPath = null,
    Object? posterPath = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      backdropPath: null == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: null == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TmdbMovieCopyWith<$Res> implements $TmdbMovieCopyWith<$Res> {
  factory _$$_TmdbMovieCopyWith(
          _$_TmdbMovie value, $Res Function(_$_TmdbMovie) then) =
      __$$_TmdbMovieCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String overview, String backdropPath, String posterPath});
}

/// @nodoc
class __$$_TmdbMovieCopyWithImpl<$Res>
    extends _$TmdbMovieCopyWithImpl<$Res, _$_TmdbMovie>
    implements _$$_TmdbMovieCopyWith<$Res> {
  __$$_TmdbMovieCopyWithImpl(
      _$_TmdbMovie _value, $Res Function(_$_TmdbMovie) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? overview = null,
    Object? backdropPath = null,
    Object? posterPath = null,
  }) {
    return _then(_$_TmdbMovie(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      backdropPath: null == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: null == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_TmdbMovie extends _TmdbMovie with DiagnosticableTreeMixin {
  const _$_TmdbMovie(
      {this.name = '',
      this.overview = '',
      this.backdropPath = '',
      this.posterPath = ''})
      : super._();

  factory _$_TmdbMovie.fromJson(Map<String, dynamic> json) =>
      _$$_TmdbMovieFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String overview;
  @override
  @JsonKey()
  final String backdropPath;
  @override
  @JsonKey()
  final String posterPath;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TmdbMovie(name: $name, overview: $overview, backdropPath: $backdropPath, posterPath: $posterPath)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TmdbMovie'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('overview', overview))
      ..add(DiagnosticsProperty('backdropPath', backdropPath))
      ..add(DiagnosticsProperty('posterPath', posterPath));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TmdbMovie &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, overview, backdropPath, posterPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TmdbMovieCopyWith<_$_TmdbMovie> get copyWith =>
      __$$_TmdbMovieCopyWithImpl<_$_TmdbMovie>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TmdbMovieToJson(
      this,
    );
  }
}

abstract class _TmdbMovie extends TmdbMovie {
  const factory _TmdbMovie(
      {final String name,
      final String overview,
      final String backdropPath,
      final String posterPath}) = _$_TmdbMovie;
  const _TmdbMovie._() : super._();

  factory _TmdbMovie.fromJson(Map<String, dynamic> json) =
      _$_TmdbMovie.fromJson;

  @override
  String get name;
  @override
  String get overview;
  @override
  String get backdropPath;
  @override
  String get posterPath;
  @override
  @JsonKey(ignore: true)
  _$$_TmdbMovieCopyWith<_$_TmdbMovie> get copyWith =>
      throw _privateConstructorUsedError;
}
