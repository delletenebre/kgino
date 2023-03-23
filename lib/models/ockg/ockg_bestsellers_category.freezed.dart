// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ockg_bestsellers_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OckgBestsellersCategory _$OckgBestsellersCategoryFromJson(
    Map<String, dynamic> json) {
  return _OckgBestsellersCategory.fromJson(json);
}

/// @nodoc
mixin _$OckgBestsellersCategory {
  String get categoryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<OckgMovie> get movies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OckgBestsellersCategoryCopyWith<OckgBestsellersCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OckgBestsellersCategoryCopyWith<$Res> {
  factory $OckgBestsellersCategoryCopyWith(OckgBestsellersCategory value,
          $Res Function(OckgBestsellersCategory) then) =
      _$OckgBestsellersCategoryCopyWithImpl<$Res, OckgBestsellersCategory>;
  @useResult
  $Res call({String categoryId, String name, List<OckgMovie> movies});
}

/// @nodoc
class _$OckgBestsellersCategoryCopyWithImpl<$Res,
        $Val extends OckgBestsellersCategory>
    implements $OckgBestsellersCategoryCopyWith<$Res> {
  _$OckgBestsellersCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? name = null,
    Object? movies = null,
  }) {
    return _then(_value.copyWith(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      movies: null == movies
          ? _value.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<OckgMovie>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OckgBestsellersCategoryCopyWith<$Res>
    implements $OckgBestsellersCategoryCopyWith<$Res> {
  factory _$$_OckgBestsellersCategoryCopyWith(_$_OckgBestsellersCategory value,
          $Res Function(_$_OckgBestsellersCategory) then) =
      __$$_OckgBestsellersCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String categoryId, String name, List<OckgMovie> movies});
}

/// @nodoc
class __$$_OckgBestsellersCategoryCopyWithImpl<$Res>
    extends _$OckgBestsellersCategoryCopyWithImpl<$Res,
        _$_OckgBestsellersCategory>
    implements _$$_OckgBestsellersCategoryCopyWith<$Res> {
  __$$_OckgBestsellersCategoryCopyWithImpl(_$_OckgBestsellersCategory _value,
      $Res Function(_$_OckgBestsellersCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? name = null,
    Object? movies = null,
  }) {
    return _then(_$_OckgBestsellersCategory(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      movies: null == movies
          ? _value._movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<OckgMovie>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_OckgBestsellersCategory extends _OckgBestsellersCategory {
  const _$_OckgBestsellersCategory(
      {required this.categoryId,
      required this.name,
      required final List<OckgMovie> movies})
      : _movies = movies,
        super._();

  factory _$_OckgBestsellersCategory.fromJson(Map<String, dynamic> json) =>
      _$$_OckgBestsellersCategoryFromJson(json);

  @override
  final String categoryId;
  @override
  final String name;
  final List<OckgMovie> _movies;
  @override
  List<OckgMovie> get movies {
    if (_movies is EqualUnmodifiableListView) return _movies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  @override
  String toString() {
    return 'OckgBestsellersCategory(categoryId: $categoryId, name: $name, movies: $movies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OckgBestsellersCategory &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._movies, _movies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, categoryId, name,
      const DeepCollectionEquality().hash(_movies));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OckgBestsellersCategoryCopyWith<_$_OckgBestsellersCategory>
      get copyWith =>
          __$$_OckgBestsellersCategoryCopyWithImpl<_$_OckgBestsellersCategory>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OckgBestsellersCategoryToJson(
      this,
    );
  }
}

abstract class _OckgBestsellersCategory extends OckgBestsellersCategory {
  const factory _OckgBestsellersCategory(
      {required final String categoryId,
      required final String name,
      required final List<OckgMovie> movies}) = _$_OckgBestsellersCategory;
  const _OckgBestsellersCategory._() : super._();

  factory _OckgBestsellersCategory.fromJson(Map<String, dynamic> json) =
      _$_OckgBestsellersCategory.fromJson;

  @override
  String get categoryId;
  @override
  String get name;
  @override
  List<OckgMovie> get movies;
  @override
  @JsonKey(ignore: true)
  _$$_OckgBestsellersCategoryCopyWith<_$_OckgBestsellersCategory>
      get copyWith => throw _privateConstructorUsedError;
}
