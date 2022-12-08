// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'movie_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MovieItem {
  /// идентификатор сайта
  @HiveField(0)
  SiteType get type => throw _privateConstructorUsedError;

  /// идентификатор фильма или сериала
  @HiveField(1)
  String get id => throw _privateConstructorUsedError;

  /// название фильма или сериала
  @HiveField(2)
  String get name => throw _privateConstructorUsedError;

  /// постер фильма или сериала
  @HiveField(3)
  String get posterUrl => throw _privateConstructorUsedError;

  /// постер фильма или сериала
  @HiveField(3)
  set posterUrl(String value) => throw _privateConstructorUsedError;

  /// включены или выключены субтитры
  @HiveField(4)
  bool get subtitlesEnabled => throw _privateConstructorUsedError;

  /// включены или выключены субтитры
  @HiveField(4)
  set subtitlesEnabled(bool value) => throw _privateConstructorUsedError;

  /// включены или выключены субтитры
  @HiveField(5)
  bool get favorite => throw _privateConstructorUsedError;

  /// включены или выключены субтитры
  @HiveField(5)
  set favorite(bool value) => throw _privateConstructorUsedError;

  /// дата последнего просмотра
  @HiveField(6)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// дата последнего просмотра
  @HiveField(6)
  set updatedAt(DateTime value) => throw _privateConstructorUsedError;

  /// список просмотренных эпизодов
  @HiveField(7)
  Map<String, EpisodeItem> get episodes => throw _privateConstructorUsedError;

  /// список просмотренных эпизодов
  @HiveField(7)
  set episodes(Map<String, EpisodeItem> value) =>
      throw _privateConstructorUsedError;

  /// оригинальное название
  String get originalName => throw _privateConstructorUsedError;

  /// описание фильма или сериала
  String get description => throw _privateConstructorUsedError;

  /// год выхода в прокат
  String get year => throw _privateConstructorUsedError;

  /// жанры
  List<String> get genres => throw _privateConstructorUsedError;

  /// страны
  List<String> get countries => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @HiveField(0) SiteType type,
            @HiveField(1) String id,
            @HiveField(2) String name,
            @HiveField(3) String posterUrl,
            @HiveField(4) bool subtitlesEnabled,
            @HiveField(5) bool favorite,
            @HiveField(6) DateTime updatedAt,
            @HiveField(7) Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)
        $default, {
    required TResult Function(
            SiteType type,
            String id,
            String name,
            String posterUrl,
            bool subtitlesEnabled,
            bool favorite,
            DateTime updatedAt,
            Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)
        tskg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @HiveField(0) SiteType type,
            @HiveField(1) String id,
            @HiveField(2) String name,
            @HiveField(3) String posterUrl,
            @HiveField(4) bool subtitlesEnabled,
            @HiveField(5) bool favorite,
            @HiveField(6) DateTime updatedAt,
            @HiveField(7) Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        $default, {
    TResult? Function(
            SiteType type,
            String id,
            String name,
            String posterUrl,
            bool subtitlesEnabled,
            bool favorite,
            DateTime updatedAt,
            Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        tskg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @HiveField(0) SiteType type,
            @HiveField(1) String id,
            @HiveField(2) String name,
            @HiveField(3) String posterUrl,
            @HiveField(4) bool subtitlesEnabled,
            @HiveField(5) bool favorite,
            @HiveField(6) DateTime updatedAt,
            @HiveField(7) Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        $default, {
    TResult Function(
            SiteType type,
            String id,
            String name,
            String posterUrl,
            bool subtitlesEnabled,
            bool favorite,
            DateTime updatedAt,
            Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        tskg,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MovieItem value) $default, {
    required TResult Function(TskgMovieItem value) tskg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MovieItem value)? $default, {
    TResult? Function(TskgMovieItem value)? tskg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MovieItem value)? $default, {
    TResult Function(TskgMovieItem value)? tskg,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MovieItemCopyWith<MovieItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieItemCopyWith<$Res> {
  factory $MovieItemCopyWith(MovieItem value, $Res Function(MovieItem) then) =
      _$MovieItemCopyWithImpl<$Res, MovieItem>;
  @useResult
  $Res call(
      {@HiveField(0) SiteType type,
      @HiveField(1) String id,
      @HiveField(2) String name,
      @HiveField(3) String posterUrl,
      @HiveField(4) bool subtitlesEnabled,
      @HiveField(5) bool favorite,
      @HiveField(6) DateTime updatedAt,
      @HiveField(7) Map<String, EpisodeItem> episodes,
      String originalName,
      String description,
      String year,
      List<String> genres,
      List<String> countries});
}

/// @nodoc
class _$MovieItemCopyWithImpl<$Res, $Val extends MovieItem>
    implements $MovieItemCopyWith<$Res> {
  _$MovieItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? name = null,
    Object? posterUrl = null,
    Object? subtitlesEnabled = null,
    Object? favorite = null,
    Object? updatedAt = null,
    Object? episodes = null,
    Object? originalName = null,
    Object? description = null,
    Object? year = null,
    Object? genres = null,
    Object? countries = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SiteType,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      posterUrl: null == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String,
      subtitlesEnabled: null == subtitlesEnabled
          ? _value.subtitlesEnabled
          : subtitlesEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as Map<String, EpisodeItem>,
      originalName: null == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MovieItemCopyWith<$Res> implements $MovieItemCopyWith<$Res> {
  factory _$$_MovieItemCopyWith(
          _$_MovieItem value, $Res Function(_$_MovieItem) then) =
      __$$_MovieItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) SiteType type,
      @HiveField(1) String id,
      @HiveField(2) String name,
      @HiveField(3) String posterUrl,
      @HiveField(4) bool subtitlesEnabled,
      @HiveField(5) bool favorite,
      @HiveField(6) DateTime updatedAt,
      @HiveField(7) Map<String, EpisodeItem> episodes,
      String originalName,
      String description,
      String year,
      List<String> genres,
      List<String> countries});
}

/// @nodoc
class __$$_MovieItemCopyWithImpl<$Res>
    extends _$MovieItemCopyWithImpl<$Res, _$_MovieItem>
    implements _$$_MovieItemCopyWith<$Res> {
  __$$_MovieItemCopyWithImpl(
      _$_MovieItem _value, $Res Function(_$_MovieItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? name = null,
    Object? posterUrl = null,
    Object? subtitlesEnabled = null,
    Object? favorite = null,
    Object? updatedAt = null,
    Object? episodes = null,
    Object? originalName = null,
    Object? description = null,
    Object? year = null,
    Object? genres = null,
    Object? countries = null,
  }) {
    return _then(_$_MovieItem(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SiteType,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      posterUrl: null == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String,
      subtitlesEnabled: null == subtitlesEnabled
          ? _value.subtitlesEnabled
          : subtitlesEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as Map<String, EpisodeItem>,
      originalName: null == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 5)
class _$_MovieItem extends _MovieItem {
  _$_MovieItem(
      {@HiveField(0) required this.type,
      @HiveField(1) required this.id,
      @HiveField(2) required this.name,
      @HiveField(3) required this.posterUrl,
      @HiveField(4) this.subtitlesEnabled = false,
      @HiveField(5) this.favorite = false,
      @HiveField(6) required this.updatedAt,
      @HiveField(7) this.episodes = const {},
      this.originalName = '',
      this.description = '',
      this.year = '',
      this.genres = const [],
      this.countries = const []})
      : super._();

  /// идентификатор сайта
  @override
  @HiveField(0)
  final SiteType type;

  /// идентификатор фильма или сериала
  @override
  @HiveField(1)
  final String id;

  /// название фильма или сериала
  @override
  @HiveField(2)
  final String name;

  /// постер фильма или сериала
  @override
  @HiveField(3)
  String posterUrl;

  /// включены или выключены субтитры
  @override
  @JsonKey()
  @HiveField(4)
  bool subtitlesEnabled;

  /// включены или выключены субтитры
  @override
  @JsonKey()
  @HiveField(5)
  bool favorite;

  /// дата последнего просмотра
  @override
  @HiveField(6)
  DateTime updatedAt;

  /// список просмотренных эпизодов
  @override
  @JsonKey()
  @HiveField(7)
  Map<String, EpisodeItem> episodes;

  /// оригинальное название
  @override
  @JsonKey()
  final String originalName;

  /// описание фильма или сериала
  @override
  @JsonKey()
  final String description;

  /// год выхода в прокат
  @override
  @JsonKey()
  final String year;

  /// жанры
  @override
  @JsonKey()
  final List<String> genres;

  /// страны
  @override
  @JsonKey()
  final List<String> countries;

  @override
  String toString() {
    return 'MovieItem(type: $type, id: $id, name: $name, posterUrl: $posterUrl, subtitlesEnabled: $subtitlesEnabled, favorite: $favorite, updatedAt: $updatedAt, episodes: $episodes, originalName: $originalName, description: $description, year: $year, genres: $genres, countries: $countries)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieItemCopyWith<_$_MovieItem> get copyWith =>
      __$$_MovieItemCopyWithImpl<_$_MovieItem>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @HiveField(0) SiteType type,
            @HiveField(1) String id,
            @HiveField(2) String name,
            @HiveField(3) String posterUrl,
            @HiveField(4) bool subtitlesEnabled,
            @HiveField(5) bool favorite,
            @HiveField(6) DateTime updatedAt,
            @HiveField(7) Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)
        $default, {
    required TResult Function(
            SiteType type,
            String id,
            String name,
            String posterUrl,
            bool subtitlesEnabled,
            bool favorite,
            DateTime updatedAt,
            Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)
        tskg,
  }) {
    return $default(
        type,
        id,
        name,
        posterUrl,
        subtitlesEnabled,
        favorite,
        updatedAt,
        episodes,
        originalName,
        description,
        year,
        genres,
        countries);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @HiveField(0) SiteType type,
            @HiveField(1) String id,
            @HiveField(2) String name,
            @HiveField(3) String posterUrl,
            @HiveField(4) bool subtitlesEnabled,
            @HiveField(5) bool favorite,
            @HiveField(6) DateTime updatedAt,
            @HiveField(7) Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        $default, {
    TResult? Function(
            SiteType type,
            String id,
            String name,
            String posterUrl,
            bool subtitlesEnabled,
            bool favorite,
            DateTime updatedAt,
            Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        tskg,
  }) {
    return $default?.call(
        type,
        id,
        name,
        posterUrl,
        subtitlesEnabled,
        favorite,
        updatedAt,
        episodes,
        originalName,
        description,
        year,
        genres,
        countries);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @HiveField(0) SiteType type,
            @HiveField(1) String id,
            @HiveField(2) String name,
            @HiveField(3) String posterUrl,
            @HiveField(4) bool subtitlesEnabled,
            @HiveField(5) bool favorite,
            @HiveField(6) DateTime updatedAt,
            @HiveField(7) Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        $default, {
    TResult Function(
            SiteType type,
            String id,
            String name,
            String posterUrl,
            bool subtitlesEnabled,
            bool favorite,
            DateTime updatedAt,
            Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        tskg,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          type,
          id,
          name,
          posterUrl,
          subtitlesEnabled,
          favorite,
          updatedAt,
          episodes,
          originalName,
          description,
          year,
          genres,
          countries);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MovieItem value) $default, {
    required TResult Function(TskgMovieItem value) tskg,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MovieItem value)? $default, {
    TResult? Function(TskgMovieItem value)? tskg,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MovieItem value)? $default, {
    TResult Function(TskgMovieItem value)? tskg,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _MovieItem extends MovieItem {
  factory _MovieItem(
      {@HiveField(0) required final SiteType type,
      @HiveField(1) required final String id,
      @HiveField(2) required final String name,
      @HiveField(3) required String posterUrl,
      @HiveField(4) bool subtitlesEnabled,
      @HiveField(5) bool favorite,
      @HiveField(6) required DateTime updatedAt,
      @HiveField(7) Map<String, EpisodeItem> episodes,
      final String originalName,
      final String description,
      final String year,
      final List<String> genres,
      final List<String> countries}) = _$_MovieItem;
  _MovieItem._() : super._();

  @override

  /// идентификатор сайта
  @HiveField(0)
  SiteType get type;
  @override

  /// идентификатор фильма или сериала
  @HiveField(1)
  String get id;
  @override

  /// название фильма или сериала
  @HiveField(2)
  String get name;
  @override

  /// постер фильма или сериала
  @HiveField(3)
  String get posterUrl;

  /// постер фильма или сериала
  @HiveField(3)
  set posterUrl(String value);
  @override

  /// включены или выключены субтитры
  @HiveField(4)
  bool get subtitlesEnabled;

  /// включены или выключены субтитры
  @HiveField(4)
  set subtitlesEnabled(bool value);
  @override

  /// включены или выключены субтитры
  @HiveField(5)
  bool get favorite;

  /// включены или выключены субтитры
  @HiveField(5)
  set favorite(bool value);
  @override

  /// дата последнего просмотра
  @HiveField(6)
  DateTime get updatedAt;

  /// дата последнего просмотра
  @HiveField(6)
  set updatedAt(DateTime value);
  @override

  /// список просмотренных эпизодов
  @HiveField(7)
  Map<String, EpisodeItem> get episodes;

  /// список просмотренных эпизодов
  @HiveField(7)
  set episodes(Map<String, EpisodeItem> value);
  @override

  /// оригинальное название
  String get originalName;
  @override

  /// описание фильма или сериала
  String get description;
  @override

  /// год выхода в прокат
  String get year;
  @override

  /// жанры
  List<String> get genres;
  @override

  /// страны
  List<String> get countries;
  @override
  @JsonKey(ignore: true)
  _$$_MovieItemCopyWith<_$_MovieItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TskgMovieItemCopyWith<$Res>
    implements $MovieItemCopyWith<$Res> {
  factory _$$TskgMovieItemCopyWith(
          _$TskgMovieItem value, $Res Function(_$TskgMovieItem) then) =
      __$$TskgMovieItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SiteType type,
      String id,
      String name,
      String posterUrl,
      bool subtitlesEnabled,
      bool favorite,
      DateTime updatedAt,
      Map<String, EpisodeItem> episodes,
      String originalName,
      String description,
      String year,
      List<String> genres,
      List<String> countries});
}

/// @nodoc
class __$$TskgMovieItemCopyWithImpl<$Res>
    extends _$MovieItemCopyWithImpl<$Res, _$TskgMovieItem>
    implements _$$TskgMovieItemCopyWith<$Res> {
  __$$TskgMovieItemCopyWithImpl(
      _$TskgMovieItem _value, $Res Function(_$TskgMovieItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? name = null,
    Object? posterUrl = null,
    Object? subtitlesEnabled = null,
    Object? favorite = null,
    Object? updatedAt = null,
    Object? episodes = null,
    Object? originalName = null,
    Object? description = null,
    Object? year = null,
    Object? genres = null,
    Object? countries = null,
  }) {
    return _then(_$TskgMovieItem(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SiteType,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      posterUrl: null == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String,
      subtitlesEnabled: null == subtitlesEnabled
          ? _value.subtitlesEnabled
          : subtitlesEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as Map<String, EpisodeItem>,
      originalName: null == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$TskgMovieItem extends TskgMovieItem with TskgMovieItemMixin {
  _$TskgMovieItem(
      {this.type = SiteType.tskg,
      required this.id,
      required this.name,
      required this.posterUrl,
      required this.subtitlesEnabled,
      required this.favorite,
      required this.updatedAt,
      this.episodes = const {},
      this.originalName = '',
      this.description = '',
      this.year = '',
      this.genres = const [],
      this.countries = const []})
      : super._();

  @override
  @JsonKey()
  SiteType type;
  @override
  String id;
  @override
  String name;
  @override
  String posterUrl;
  @override
  bool subtitlesEnabled;
  @override
  bool favorite;
  @override
  DateTime updatedAt;
  @override
  @JsonKey()
  Map<String, EpisodeItem> episodes;
  @override
  @JsonKey()
  String originalName;
  @override
  @JsonKey()
  String description;
  @override
  @JsonKey()
  String year;
  @override
  @JsonKey()
  List<String> genres;
  @override
  @JsonKey()
  List<String> countries;

  @override
  String toString() {
    return 'MovieItem.tskg(type: $type, id: $id, name: $name, posterUrl: $posterUrl, subtitlesEnabled: $subtitlesEnabled, favorite: $favorite, updatedAt: $updatedAt, episodes: $episodes, originalName: $originalName, description: $description, year: $year, genres: $genres, countries: $countries)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TskgMovieItemCopyWith<_$TskgMovieItem> get copyWith =>
      __$$TskgMovieItemCopyWithImpl<_$TskgMovieItem>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @HiveField(0) SiteType type,
            @HiveField(1) String id,
            @HiveField(2) String name,
            @HiveField(3) String posterUrl,
            @HiveField(4) bool subtitlesEnabled,
            @HiveField(5) bool favorite,
            @HiveField(6) DateTime updatedAt,
            @HiveField(7) Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)
        $default, {
    required TResult Function(
            SiteType type,
            String id,
            String name,
            String posterUrl,
            bool subtitlesEnabled,
            bool favorite,
            DateTime updatedAt,
            Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)
        tskg,
  }) {
    return tskg(
        type,
        id,
        name,
        posterUrl,
        subtitlesEnabled,
        favorite,
        updatedAt,
        episodes,
        originalName,
        description,
        year,
        genres,
        countries);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @HiveField(0) SiteType type,
            @HiveField(1) String id,
            @HiveField(2) String name,
            @HiveField(3) String posterUrl,
            @HiveField(4) bool subtitlesEnabled,
            @HiveField(5) bool favorite,
            @HiveField(6) DateTime updatedAt,
            @HiveField(7) Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        $default, {
    TResult? Function(
            SiteType type,
            String id,
            String name,
            String posterUrl,
            bool subtitlesEnabled,
            bool favorite,
            DateTime updatedAt,
            Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        tskg,
  }) {
    return tskg?.call(
        type,
        id,
        name,
        posterUrl,
        subtitlesEnabled,
        favorite,
        updatedAt,
        episodes,
        originalName,
        description,
        year,
        genres,
        countries);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @HiveField(0) SiteType type,
            @HiveField(1) String id,
            @HiveField(2) String name,
            @HiveField(3) String posterUrl,
            @HiveField(4) bool subtitlesEnabled,
            @HiveField(5) bool favorite,
            @HiveField(6) DateTime updatedAt,
            @HiveField(7) Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        $default, {
    TResult Function(
            SiteType type,
            String id,
            String name,
            String posterUrl,
            bool subtitlesEnabled,
            bool favorite,
            DateTime updatedAt,
            Map<String, EpisodeItem> episodes,
            String originalName,
            String description,
            String year,
            List<String> genres,
            List<String> countries)?
        tskg,
    required TResult orElse(),
  }) {
    if (tskg != null) {
      return tskg(
          type,
          id,
          name,
          posterUrl,
          subtitlesEnabled,
          favorite,
          updatedAt,
          episodes,
          originalName,
          description,
          year,
          genres,
          countries);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MovieItem value) $default, {
    required TResult Function(TskgMovieItem value) tskg,
  }) {
    return tskg(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MovieItem value)? $default, {
    TResult? Function(TskgMovieItem value)? tskg,
  }) {
    return tskg?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MovieItem value)? $default, {
    TResult Function(TskgMovieItem value)? tskg,
    required TResult orElse(),
  }) {
    if (tskg != null) {
      return tskg(this);
    }
    return orElse();
  }
}

abstract class TskgMovieItem extends MovieItem implements TskgMovieItemMixin {
  factory TskgMovieItem(
      {SiteType type,
      required String id,
      required String name,
      required String posterUrl,
      required bool subtitlesEnabled,
      required bool favorite,
      required DateTime updatedAt,
      Map<String, EpisodeItem> episodes,
      String originalName,
      String description,
      String year,
      List<String> genres,
      List<String> countries}) = _$TskgMovieItem;
  TskgMovieItem._() : super._();

  @override
  SiteType get type;
  set type(SiteType value);
  @override
  String get id;
  set id(String value);
  @override
  String get name;
  set name(String value);
  @override
  String get posterUrl;
  set posterUrl(String value);
  @override
  bool get subtitlesEnabled;
  set subtitlesEnabled(bool value);
  @override
  bool get favorite;
  set favorite(bool value);
  @override
  DateTime get updatedAt;
  set updatedAt(DateTime value);
  @override
  Map<String, EpisodeItem> get episodes;
  set episodes(Map<String, EpisodeItem> value);
  @override
  String get originalName;
  set originalName(String value);
  @override
  String get description;
  set description(String value);
  @override
  String get year;
  set year(String value);
  @override
  List<String> get genres;
  set genres(List<String> value);
  @override
  List<String> get countries;
  set countries(List<String> value);
  @override
  @JsonKey(ignore: true)
  _$$TskgMovieItemCopyWith<_$TskgMovieItem> get copyWith =>
      throw _privateConstructorUsedError;
}
