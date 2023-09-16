// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) {
  return _MediaItem.fromJson(json);
}

/// @nodoc
mixin _$MediaItem {
  OnlineService get onlineService => throw _privateConstructorUsedError;
  MediaItemType get mediaItemType => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get originalTitle => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  String? get posterImage => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;
  String get year => throw _privateConstructorUsedError;
  List<String> get countries => throw _privateConstructorUsedError;
  TmdbItem? get tmdb => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MediaItemCopyWith<MediaItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaItemCopyWith<$Res> {
  factory $MediaItemCopyWith(MediaItem value, $Res Function(MediaItem) then) =
      _$MediaItemCopyWithImpl<$Res, MediaItem>;
  @useResult
  $Res call(
      {OnlineService onlineService,
      MediaItemType mediaItemType,
      String id,
      String title,
      String originalTitle,
      String overview,
      String? posterImage,
      List<String> genres,
      String year,
      List<String> countries,
      TmdbItem? tmdb});

  $TmdbItemCopyWith<$Res>? get tmdb;
}

/// @nodoc
class _$MediaItemCopyWithImpl<$Res, $Val extends MediaItem>
    implements $MediaItemCopyWith<$Res> {
  _$MediaItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onlineService = null,
    Object? mediaItemType = null,
    Object? id = null,
    Object? title = null,
    Object? originalTitle = null,
    Object? overview = null,
    Object? posterImage = freezed,
    Object? genres = null,
    Object? year = null,
    Object? countries = null,
    Object? tmdb = freezed,
  }) {
    return _then(_value.copyWith(
      onlineService: null == onlineService
          ? _value.onlineService
          : onlineService // ignore: cast_nullable_to_non_nullable
              as OnlineService,
      mediaItemType: null == mediaItemType
          ? _value.mediaItemType
          : mediaItemType // ignore: cast_nullable_to_non_nullable
              as MediaItemType,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      originalTitle: null == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      posterImage: freezed == posterImage
          ? _value.posterImage
          : posterImage // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tmdb: freezed == tmdb
          ? _value.tmdb
          : tmdb // ignore: cast_nullable_to_non_nullable
              as TmdbItem?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TmdbItemCopyWith<$Res>? get tmdb {
    if (_value.tmdb == null) {
      return null;
    }

    return $TmdbItemCopyWith<$Res>(_value.tmdb!, (value) {
      return _then(_value.copyWith(tmdb: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MediaItemCopyWith<$Res> implements $MediaItemCopyWith<$Res> {
  factory _$$_MediaItemCopyWith(
          _$_MediaItem value, $Res Function(_$_MediaItem) then) =
      __$$_MediaItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OnlineService onlineService,
      MediaItemType mediaItemType,
      String id,
      String title,
      String originalTitle,
      String overview,
      String? posterImage,
      List<String> genres,
      String year,
      List<String> countries,
      TmdbItem? tmdb});

  @override
  $TmdbItemCopyWith<$Res>? get tmdb;
}

/// @nodoc
class __$$_MediaItemCopyWithImpl<$Res>
    extends _$MediaItemCopyWithImpl<$Res, _$_MediaItem>
    implements _$$_MediaItemCopyWith<$Res> {
  __$$_MediaItemCopyWithImpl(
      _$_MediaItem _value, $Res Function(_$_MediaItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onlineService = null,
    Object? mediaItemType = null,
    Object? id = null,
    Object? title = null,
    Object? originalTitle = null,
    Object? overview = null,
    Object? posterImage = freezed,
    Object? genres = null,
    Object? year = null,
    Object? countries = null,
    Object? tmdb = freezed,
  }) {
    return _then(_$_MediaItem(
      onlineService: null == onlineService
          ? _value.onlineService
          : onlineService // ignore: cast_nullable_to_non_nullable
              as OnlineService,
      mediaItemType: null == mediaItemType
          ? _value.mediaItemType
          : mediaItemType // ignore: cast_nullable_to_non_nullable
              as MediaItemType,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      originalTitle: null == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      posterImage: freezed == posterImage
          ? _value.posterImage
          : posterImage // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      countries: null == countries
          ? _value._countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tmdb: freezed == tmdb
          ? _value.tmdb
          : tmdb // ignore: cast_nullable_to_non_nullable
              as TmdbItem?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MediaItem extends _MediaItem with DiagnosticableTreeMixin {
  _$_MediaItem(
      {required this.onlineService,
      required this.mediaItemType,
      this.id = '',
      this.title = '',
      this.originalTitle = '',
      this.overview = '',
      this.posterImage,
      final List<String> genres = const [],
      this.year = '',
      final List<String> countries = const [],
      this.tmdb})
      : _genres = genres,
        _countries = countries,
        super._();

  factory _$_MediaItem.fromJson(Map<String, dynamic> json) =>
      _$$_MediaItemFromJson(json);

  @override
  final OnlineService onlineService;
  @override
  final MediaItemType mediaItemType;
  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String originalTitle;
  @override
  @JsonKey()
  final String overview;
  @override
  final String? posterImage;
  final List<String> _genres;
  @override
  @JsonKey()
  List<String> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  @JsonKey()
  final String year;
  final List<String> _countries;
  @override
  @JsonKey()
  List<String> get countries {
    if (_countries is EqualUnmodifiableListView) return _countries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_countries);
  }

  @override
  final TmdbItem? tmdb;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MediaItem(onlineService: $onlineService, mediaItemType: $mediaItemType, id: $id, title: $title, originalTitle: $originalTitle, overview: $overview, posterImage: $posterImage, genres: $genres, year: $year, countries: $countries, tmdb: $tmdb)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MediaItem'))
      ..add(DiagnosticsProperty('onlineService', onlineService))
      ..add(DiagnosticsProperty('mediaItemType', mediaItemType))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('originalTitle', originalTitle))
      ..add(DiagnosticsProperty('overview', overview))
      ..add(DiagnosticsProperty('posterImage', posterImage))
      ..add(DiagnosticsProperty('genres', genres))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('countries', countries))
      ..add(DiagnosticsProperty('tmdb', tmdb));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MediaItem &&
            (identical(other.onlineService, onlineService) ||
                other.onlineService == onlineService) &&
            (identical(other.mediaItemType, mediaItemType) ||
                other.mediaItemType == mediaItemType) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.originalTitle, originalTitle) ||
                other.originalTitle == originalTitle) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterImage, posterImage) ||
                other.posterImage == posterImage) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            (identical(other.year, year) || other.year == year) &&
            const DeepCollectionEquality()
                .equals(other._countries, _countries) &&
            (identical(other.tmdb, tmdb) || other.tmdb == tmdb));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      onlineService,
      mediaItemType,
      id,
      title,
      originalTitle,
      overview,
      posterImage,
      const DeepCollectionEquality().hash(_genres),
      year,
      const DeepCollectionEquality().hash(_countries),
      tmdb);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MediaItemCopyWith<_$_MediaItem> get copyWith =>
      __$$_MediaItemCopyWithImpl<_$_MediaItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MediaItemToJson(
      this,
    );
  }
}

abstract class _MediaItem extends MediaItem {
  factory _MediaItem(
      {required final OnlineService onlineService,
      required final MediaItemType mediaItemType,
      final String id,
      final String title,
      final String originalTitle,
      final String overview,
      final String? posterImage,
      final List<String> genres,
      final String year,
      final List<String> countries,
      final TmdbItem? tmdb}) = _$_MediaItem;
  _MediaItem._() : super._();

  factory _MediaItem.fromJson(Map<String, dynamic> json) =
      _$_MediaItem.fromJson;

  @override
  OnlineService get onlineService;
  @override
  MediaItemType get mediaItemType;
  @override
  String get id;
  @override
  String get title;
  @override
  String get originalTitle;
  @override
  String get overview;
  @override
  String? get posterImage;
  @override
  List<String> get genres;
  @override
  String get year;
  @override
  List<String> get countries;
  @override
  TmdbItem? get tmdb;
  @override
  @JsonKey(ignore: true)
  _$$_MediaItemCopyWith<_$_MediaItem> get copyWith =>
      throw _privateConstructorUsedError;
}
