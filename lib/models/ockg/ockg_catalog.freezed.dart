// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ockg_catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OckgCatalog _$OckgCatalogFromJson(Map<String, dynamic> json) {
  return _OckgCatalog.fromJson(json);
}

/// @nodoc
mixin _$OckgCatalog {
  @IntConverter()
  int get total => throw _privateConstructorUsedError;
  @IntConverter()
  int get offset => throw _privateConstructorUsedError;
  @IntConverter()
  int get pagesize => throw _privateConstructorUsedError;
  List<OckgMovie> get movies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OckgCatalogCopyWith<OckgCatalog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OckgCatalogCopyWith<$Res> {
  factory $OckgCatalogCopyWith(
          OckgCatalog value, $Res Function(OckgCatalog) then) =
      _$OckgCatalogCopyWithImpl<$Res, OckgCatalog>;
  @useResult
  $Res call(
      {@IntConverter() int total,
      @IntConverter() int offset,
      @IntConverter() int pagesize,
      List<OckgMovie> movies});
}

/// @nodoc
class _$OckgCatalogCopyWithImpl<$Res, $Val extends OckgCatalog>
    implements $OckgCatalogCopyWith<$Res> {
  _$OckgCatalogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? offset = null,
    Object? pagesize = null,
    Object? movies = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      pagesize: null == pagesize
          ? _value.pagesize
          : pagesize // ignore: cast_nullable_to_non_nullable
              as int,
      movies: null == movies
          ? _value.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<OckgMovie>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OckgCatalogCopyWith<$Res>
    implements $OckgCatalogCopyWith<$Res> {
  factory _$$_OckgCatalogCopyWith(
          _$_OckgCatalog value, $Res Function(_$_OckgCatalog) then) =
      __$$_OckgCatalogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IntConverter() int total,
      @IntConverter() int offset,
      @IntConverter() int pagesize,
      List<OckgMovie> movies});
}

/// @nodoc
class __$$_OckgCatalogCopyWithImpl<$Res>
    extends _$OckgCatalogCopyWithImpl<$Res, _$_OckgCatalog>
    implements _$$_OckgCatalogCopyWith<$Res> {
  __$$_OckgCatalogCopyWithImpl(
      _$_OckgCatalog _value, $Res Function(_$_OckgCatalog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? offset = null,
    Object? pagesize = null,
    Object? movies = null,
  }) {
    return _then(_$_OckgCatalog(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      pagesize: null == pagesize
          ? _value.pagesize
          : pagesize // ignore: cast_nullable_to_non_nullable
              as int,
      movies: null == movies
          ? _value._movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<OckgMovie>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_OckgCatalog extends _OckgCatalog {
  const _$_OckgCatalog(
      {@IntConverter() this.total = 0,
      @IntConverter() this.offset = 0,
      @IntConverter() this.pagesize = 20,
      final List<OckgMovie> movies = const []})
      : _movies = movies,
        super._();

  factory _$_OckgCatalog.fromJson(Map<String, dynamic> json) =>
      _$$_OckgCatalogFromJson(json);

  @override
  @JsonKey()
  @IntConverter()
  final int total;
  @override
  @JsonKey()
  @IntConverter()
  final int offset;
  @override
  @JsonKey()
  @IntConverter()
  final int pagesize;
  final List<OckgMovie> _movies;
  @override
  @JsonKey()
  List<OckgMovie> get movies {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  @override
  String toString() {
    return 'OckgCatalog(total: $total, offset: $offset, pagesize: $pagesize, movies: $movies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OckgCatalog &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.pagesize, pagesize) ||
                other.pagesize == pagesize) &&
            const DeepCollectionEquality().equals(other._movies, _movies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, total, offset, pagesize,
      const DeepCollectionEquality().hash(_movies));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OckgCatalogCopyWith<_$_OckgCatalog> get copyWith =>
      __$$_OckgCatalogCopyWithImpl<_$_OckgCatalog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OckgCatalogToJson(
      this,
    );
  }
}

abstract class _OckgCatalog extends OckgCatalog {
  const factory _OckgCatalog(
      {@IntConverter() final int total,
      @IntConverter() final int offset,
      @IntConverter() final int pagesize,
      final List<OckgMovie> movies}) = _$_OckgCatalog;
  const _OckgCatalog._() : super._();

  factory _OckgCatalog.fromJson(Map<String, dynamic> json) =
      _$_OckgCatalog.fromJson;

  @override
  @IntConverter()
  int get total;
  @override
  @IntConverter()
  int get offset;
  @override
  @IntConverter()
  int get pagesize;
  @override
  List<OckgMovie> get movies;
  @override
  @JsonKey(ignore: true)
  _$$_OckgCatalogCopyWith<_$_OckgCatalog> get copyWith =>
      throw _privateConstructorUsedError;
}
