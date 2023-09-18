// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
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
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call(
      {String id,
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
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
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
abstract class _$$_ItemCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$_ItemCopyWith(_$_Item value, $Res Function(_$_Item) then) =
      __$$_ItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
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
class __$$_ItemCopyWithImpl<$Res> extends _$ItemCopyWithImpl<$Res, _$_Item>
    implements _$$_ItemCopyWith<$Res> {
  __$$_ItemCopyWithImpl(_$_Item _value, $Res Function(_$_Item) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
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
    return _then(_$_Item(
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
class _$_Item extends _Item with DiagnosticableTreeMixin {
  _$_Item(
      {this.id = '',
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

  factory _$_Item.fromJson(Map<String, dynamic> json) => _$$_ItemFromJson(json);

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
    return 'Item(id: $id, title: $title, originalTitle: $originalTitle, overview: $overview, posterImage: $posterImage, genres: $genres, year: $year, countries: $countries, tmdb: $tmdb)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Item'))
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
            other is _$_Item &&
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
  _$$_ItemCopyWith<_$_Item> get copyWith =>
      __$$_ItemCopyWithImpl<_$_Item>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemToJson(
      this,
    );
  }
}

abstract class _Item extends Item {
  factory _Item(
      {final String id,
      final String title,
      final String originalTitle,
      final String overview,
      final String? posterImage,
      final List<String> genres,
      final String year,
      final List<String> countries,
      final TmdbItem? tmdb}) = _$_Item;
  _Item._() : super._();

  factory _Item.fromJson(Map<String, dynamic> json) = _$_Item.fromJson;

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
  _$$_ItemCopyWith<_$_Item> get copyWith => throw _privateConstructorUsedError;
}

FilmixItem _$FilmixItemFromJson(Map<String, dynamic> json) {
  return _FilmixItem.fromJson(json);
}

/// @nodoc
mixin _$FilmixItem {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilmixItemCopyWith<$Res> {
  factory $FilmixItemCopyWith(
          FilmixItem value, $Res Function(FilmixItem) then) =
      _$FilmixItemCopyWithImpl<$Res, FilmixItem>;
}

/// @nodoc
class _$FilmixItemCopyWithImpl<$Res, $Val extends FilmixItem>
    implements $FilmixItemCopyWith<$Res> {
  _$FilmixItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_FilmixItemCopyWith<$Res> {
  factory _$$_FilmixItemCopyWith(
          _$_FilmixItem value, $Res Function(_$_FilmixItem) then) =
      __$$_FilmixItemCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_FilmixItemCopyWithImpl<$Res>
    extends _$FilmixItemCopyWithImpl<$Res, _$_FilmixItem>
    implements _$$_FilmixItemCopyWith<$Res> {
  __$$_FilmixItemCopyWithImpl(
      _$_FilmixItem _value, $Res Function(_$_FilmixItem) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_FilmixItem extends _FilmixItem with DiagnosticableTreeMixin, Tmdb {
  _$_FilmixItem() : super._();

  factory _$_FilmixItem.fromJson(Map<String, dynamic> json) =>
      _$$_FilmixItemFromJson(json);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FilmixItem()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'FilmixItem'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_FilmixItem);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$_FilmixItemToJson(
      this,
    );
  }
}

abstract class _FilmixItem extends FilmixItem implements Tmdb {
  factory _FilmixItem() = _$_FilmixItem;
  _FilmixItem._() : super._();

  factory _FilmixItem.fromJson(Map<String, dynamic> json) =
      _$_FilmixItem.fromJson;
}
