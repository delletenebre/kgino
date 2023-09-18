// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filmix_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FilmixItem _$FilmixItemFromJson(Map<String, dynamic> json) {
  return _FilmixItem.fromJson(json);
}

/// @nodoc
mixin _$FilmixItem {
  @IntConverter()
  int get id => throw _privateConstructorUsedError;
  @IntConverter()
  int get section => throw _privateConstructorUsedError;
  @IntConverter()
  int get year => throw _privateConstructorUsedError;
  @IntConverter()
  int get yearEnd => throw _privateConstructorUsedError;
  @IntConverter()
  int get duration => throw _privateConstructorUsedError;
  String get poster => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get originalTitle => throw _privateConstructorUsedError;
  DateTime? get dateAtom => throw _privateConstructorUsedError;
  bool get favorited => throw _privateConstructorUsedError;
  bool get watchLater => throw _privateConstructorUsedError;
  @HtmlRemoveConverter()
  String get shortStory => throw _privateConstructorUsedError;
  String get rip => throw _privateConstructorUsedError;
  String get quality => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<String> get actors => throw _privateConstructorUsedError;
  List<String> get directors => throw _privateConstructorUsedError;
  List<String> get countries => throw _privateConstructorUsedError;
  @DoubleConverter()
  double get kpRating => throw _privateConstructorUsedError;
  @DoubleConverter()
  double get imdbRating => throw _privateConstructorUsedError;
  FlmxPlayerLinks get playerLinks => throw _privateConstructorUsedError;
  FlmxLastEpisode? get lastEpisode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilmixItemCopyWith<FilmixItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilmixItemCopyWith<$Res> {
  factory $FilmixItemCopyWith(
          FilmixItem value, $Res Function(FilmixItem) then) =
      _$FilmixItemCopyWithImpl<$Res, FilmixItem>;
  @useResult
  $Res call(
      {@IntConverter() int id,
      @IntConverter() int section,
      @IntConverter() int year,
      @IntConverter() int yearEnd,
      @IntConverter() int duration,
      String poster,
      String title,
      String originalTitle,
      DateTime? dateAtom,
      bool favorited,
      bool watchLater,
      @HtmlRemoveConverter() String shortStory,
      String rip,
      String quality,
      List<String> categories,
      List<String> actors,
      List<String> directors,
      List<String> countries,
      @DoubleConverter() double kpRating,
      @DoubleConverter() double imdbRating,
      FlmxPlayerLinks playerLinks,
      FlmxLastEpisode? lastEpisode});

  $FlmxPlayerLinksCopyWith<$Res> get playerLinks;
  $FlmxLastEpisodeCopyWith<$Res>? get lastEpisode;
}

/// @nodoc
class _$FilmixItemCopyWithImpl<$Res, $Val extends FilmixItem>
    implements $FilmixItemCopyWith<$Res> {
  _$FilmixItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? section = null,
    Object? year = null,
    Object? yearEnd = null,
    Object? duration = null,
    Object? poster = null,
    Object? title = null,
    Object? originalTitle = null,
    Object? dateAtom = freezed,
    Object? favorited = null,
    Object? watchLater = null,
    Object? shortStory = null,
    Object? rip = null,
    Object? quality = null,
    Object? categories = null,
    Object? actors = null,
    Object? directors = null,
    Object? countries = null,
    Object? kpRating = null,
    Object? imdbRating = null,
    Object? playerLinks = null,
    Object? lastEpisode = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      yearEnd: null == yearEnd
          ? _value.yearEnd
          : yearEnd // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      poster: null == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      originalTitle: null == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String,
      dateAtom: freezed == dateAtom
          ? _value.dateAtom
          : dateAtom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      favorited: null == favorited
          ? _value.favorited
          : favorited // ignore: cast_nullable_to_non_nullable
              as bool,
      watchLater: null == watchLater
          ? _value.watchLater
          : watchLater // ignore: cast_nullable_to_non_nullable
              as bool,
      shortStory: null == shortStory
          ? _value.shortStory
          : shortStory // ignore: cast_nullable_to_non_nullable
              as String,
      rip: null == rip
          ? _value.rip
          : rip // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      actors: null == actors
          ? _value.actors
          : actors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      directors: null == directors
          ? _value.directors
          : directors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
      kpRating: null == kpRating
          ? _value.kpRating
          : kpRating // ignore: cast_nullable_to_non_nullable
              as double,
      imdbRating: null == imdbRating
          ? _value.imdbRating
          : imdbRating // ignore: cast_nullable_to_non_nullable
              as double,
      playerLinks: null == playerLinks
          ? _value.playerLinks
          : playerLinks // ignore: cast_nullable_to_non_nullable
              as FlmxPlayerLinks,
      lastEpisode: freezed == lastEpisode
          ? _value.lastEpisode
          : lastEpisode // ignore: cast_nullable_to_non_nullable
              as FlmxLastEpisode?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FlmxPlayerLinksCopyWith<$Res> get playerLinks {
    return $FlmxPlayerLinksCopyWith<$Res>(_value.playerLinks, (value) {
      return _then(_value.copyWith(playerLinks: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FlmxLastEpisodeCopyWith<$Res>? get lastEpisode {
    if (_value.lastEpisode == null) {
      return null;
    }

    return $FlmxLastEpisodeCopyWith<$Res>(_value.lastEpisode!, (value) {
      return _then(_value.copyWith(lastEpisode: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FilmixItemCopyWith<$Res>
    implements $FilmixItemCopyWith<$Res> {
  factory _$$_FilmixItemCopyWith(
          _$_FilmixItem value, $Res Function(_$_FilmixItem) then) =
      __$$_FilmixItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IntConverter() int id,
      @IntConverter() int section,
      @IntConverter() int year,
      @IntConverter() int yearEnd,
      @IntConverter() int duration,
      String poster,
      String title,
      String originalTitle,
      DateTime? dateAtom,
      bool favorited,
      bool watchLater,
      @HtmlRemoveConverter() String shortStory,
      String rip,
      String quality,
      List<String> categories,
      List<String> actors,
      List<String> directors,
      List<String> countries,
      @DoubleConverter() double kpRating,
      @DoubleConverter() double imdbRating,
      FlmxPlayerLinks playerLinks,
      FlmxLastEpisode? lastEpisode});

  @override
  $FlmxPlayerLinksCopyWith<$Res> get playerLinks;
  @override
  $FlmxLastEpisodeCopyWith<$Res>? get lastEpisode;
}

/// @nodoc
class __$$_FilmixItemCopyWithImpl<$Res>
    extends _$FilmixItemCopyWithImpl<$Res, _$_FilmixItem>
    implements _$$_FilmixItemCopyWith<$Res> {
  __$$_FilmixItemCopyWithImpl(
      _$_FilmixItem _value, $Res Function(_$_FilmixItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? section = null,
    Object? year = null,
    Object? yearEnd = null,
    Object? duration = null,
    Object? poster = null,
    Object? title = null,
    Object? originalTitle = null,
    Object? dateAtom = freezed,
    Object? favorited = null,
    Object? watchLater = null,
    Object? shortStory = null,
    Object? rip = null,
    Object? quality = null,
    Object? categories = null,
    Object? actors = null,
    Object? directors = null,
    Object? countries = null,
    Object? kpRating = null,
    Object? imdbRating = null,
    Object? playerLinks = null,
    Object? lastEpisode = freezed,
  }) {
    return _then(_$_FilmixItem(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      yearEnd: null == yearEnd
          ? _value.yearEnd
          : yearEnd // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      poster: null == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      originalTitle: null == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String,
      dateAtom: freezed == dateAtom
          ? _value.dateAtom
          : dateAtom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      favorited: null == favorited
          ? _value.favorited
          : favorited // ignore: cast_nullable_to_non_nullable
              as bool,
      watchLater: null == watchLater
          ? _value.watchLater
          : watchLater // ignore: cast_nullable_to_non_nullable
              as bool,
      shortStory: null == shortStory
          ? _value.shortStory
          : shortStory // ignore: cast_nullable_to_non_nullable
              as String,
      rip: null == rip
          ? _value.rip
          : rip // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      actors: null == actors
          ? _value._actors
          : actors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      directors: null == directors
          ? _value._directors
          : directors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      countries: null == countries
          ? _value._countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
      kpRating: null == kpRating
          ? _value.kpRating
          : kpRating // ignore: cast_nullable_to_non_nullable
              as double,
      imdbRating: null == imdbRating
          ? _value.imdbRating
          : imdbRating // ignore: cast_nullable_to_non_nullable
              as double,
      playerLinks: null == playerLinks
          ? _value.playerLinks
          : playerLinks // ignore: cast_nullable_to_non_nullable
              as FlmxPlayerLinks,
      lastEpisode: freezed == lastEpisode
          ? _value.lastEpisode
          : lastEpisode // ignore: cast_nullable_to_non_nullable
              as FlmxLastEpisode?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_FilmixItem extends _FilmixItem {
  const _$_FilmixItem(
      {@IntConverter() this.id = 0,
      @IntConverter() this.section = 0,
      @IntConverter() this.year = 0,
      @IntConverter() this.yearEnd = 0,
      @IntConverter() this.duration = 0,
      this.poster = '',
      this.title = '',
      this.originalTitle = '',
      this.dateAtom,
      this.favorited = false,
      this.watchLater = false,
      @HtmlRemoveConverter() this.shortStory = '',
      this.rip = '',
      this.quality = '',
      final List<String> categories = const [],
      final List<String> actors = const [],
      final List<String> directors = const [],
      final List<String> countries = const [],
      @DoubleConverter() this.kpRating = 0.0,
      @DoubleConverter() this.imdbRating = 0.0,
      this.playerLinks = const FlmxPlayerLinks(),
      this.lastEpisode})
      : _categories = categories,
        _actors = actors,
        _directors = directors,
        _countries = countries,
        super._();

  factory _$_FilmixItem.fromJson(Map<String, dynamic> json) =>
      _$$_FilmixItemFromJson(json);

  @override
  @JsonKey()
  @IntConverter()
  final int id;
  @override
  @JsonKey()
  @IntConverter()
  final int section;
  @override
  @JsonKey()
  @IntConverter()
  final int year;
  @override
  @JsonKey()
  @IntConverter()
  final int yearEnd;
  @override
  @JsonKey()
  @IntConverter()
  final int duration;
  @override
  @JsonKey()
  final String poster;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String originalTitle;
  @override
  final DateTime? dateAtom;
  @override
  @JsonKey()
  final bool favorited;
  @override
  @JsonKey()
  final bool watchLater;
  @override
  @JsonKey()
  @HtmlRemoveConverter()
  final String shortStory;
  @override
  @JsonKey()
  final String rip;
  @override
  @JsonKey()
  final String quality;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<String> _actors;
  @override
  @JsonKey()
  List<String> get actors {
    if (_actors is EqualUnmodifiableListView) return _actors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actors);
  }

  final List<String> _directors;
  @override
  @JsonKey()
  List<String> get directors {
    if (_directors is EqualUnmodifiableListView) return _directors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_directors);
  }

  final List<String> _countries;
  @override
  @JsonKey()
  List<String> get countries {
    if (_countries is EqualUnmodifiableListView) return _countries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_countries);
  }

  @override
  @JsonKey()
  @DoubleConverter()
  final double kpRating;
  @override
  @JsonKey()
  @DoubleConverter()
  final double imdbRating;
  @override
  @JsonKey()
  final FlmxPlayerLinks playerLinks;
  @override
  final FlmxLastEpisode? lastEpisode;

  @override
  String toString() {
    return 'FilmixItem(id: $id, section: $section, year: $year, yearEnd: $yearEnd, duration: $duration, poster: $poster, title: $title, originalTitle: $originalTitle, dateAtom: $dateAtom, favorited: $favorited, watchLater: $watchLater, shortStory: $shortStory, rip: $rip, quality: $quality, categories: $categories, actors: $actors, directors: $directors, countries: $countries, kpRating: $kpRating, imdbRating: $imdbRating, playerLinks: $playerLinks, lastEpisode: $lastEpisode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FilmixItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.yearEnd, yearEnd) || other.yearEnd == yearEnd) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.poster, poster) || other.poster == poster) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.originalTitle, originalTitle) ||
                other.originalTitle == originalTitle) &&
            (identical(other.dateAtom, dateAtom) ||
                other.dateAtom == dateAtom) &&
            (identical(other.favorited, favorited) ||
                other.favorited == favorited) &&
            (identical(other.watchLater, watchLater) ||
                other.watchLater == watchLater) &&
            (identical(other.shortStory, shortStory) ||
                other.shortStory == shortStory) &&
            (identical(other.rip, rip) || other.rip == rip) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._actors, _actors) &&
            const DeepCollectionEquality()
                .equals(other._directors, _directors) &&
            const DeepCollectionEquality()
                .equals(other._countries, _countries) &&
            (identical(other.kpRating, kpRating) ||
                other.kpRating == kpRating) &&
            (identical(other.imdbRating, imdbRating) ||
                other.imdbRating == imdbRating) &&
            (identical(other.playerLinks, playerLinks) ||
                other.playerLinks == playerLinks) &&
            (identical(other.lastEpisode, lastEpisode) ||
                other.lastEpisode == lastEpisode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        section,
        year,
        yearEnd,
        duration,
        poster,
        title,
        originalTitle,
        dateAtom,
        favorited,
        watchLater,
        shortStory,
        rip,
        quality,
        const DeepCollectionEquality().hash(_categories),
        const DeepCollectionEquality().hash(_actors),
        const DeepCollectionEquality().hash(_directors),
        const DeepCollectionEquality().hash(_countries),
        kpRating,
        imdbRating,
        playerLinks,
        lastEpisode
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FilmixItemCopyWith<_$_FilmixItem> get copyWith =>
      __$$_FilmixItemCopyWithImpl<_$_FilmixItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FilmixItemToJson(
      this,
    );
  }
}

abstract class _FilmixItem extends FilmixItem {
  const factory _FilmixItem(
      {@IntConverter() final int id,
      @IntConverter() final int section,
      @IntConverter() final int year,
      @IntConverter() final int yearEnd,
      @IntConverter() final int duration,
      final String poster,
      final String title,
      final String originalTitle,
      final DateTime? dateAtom,
      final bool favorited,
      final bool watchLater,
      @HtmlRemoveConverter() final String shortStory,
      final String rip,
      final String quality,
      final List<String> categories,
      final List<String> actors,
      final List<String> directors,
      final List<String> countries,
      @DoubleConverter() final double kpRating,
      @DoubleConverter() final double imdbRating,
      final FlmxPlayerLinks playerLinks,
      final FlmxLastEpisode? lastEpisode}) = _$_FilmixItem;
  const _FilmixItem._() : super._();

  factory _FilmixItem.fromJson(Map<String, dynamic> json) =
      _$_FilmixItem.fromJson;

  @override
  @IntConverter()
  int get id;
  @override
  @IntConverter()
  int get section;
  @override
  @IntConverter()
  int get year;
  @override
  @IntConverter()
  int get yearEnd;
  @override
  @IntConverter()
  int get duration;
  @override
  String get poster;
  @override
  String get title;
  @override
  String get originalTitle;
  @override
  DateTime? get dateAtom;
  @override
  bool get favorited;
  @override
  bool get watchLater;
  @override
  @HtmlRemoveConverter()
  String get shortStory;
  @override
  String get rip;
  @override
  String get quality;
  @override
  List<String> get categories;
  @override
  List<String> get actors;
  @override
  List<String> get directors;
  @override
  List<String> get countries;
  @override
  @DoubleConverter()
  double get kpRating;
  @override
  @DoubleConverter()
  double get imdbRating;
  @override
  FlmxPlayerLinks get playerLinks;
  @override
  FlmxLastEpisode? get lastEpisode;
  @override
  @JsonKey(ignore: true)
  _$$_FilmixItemCopyWith<_$_FilmixItem> get copyWith =>
      throw _privateConstructorUsedError;
}