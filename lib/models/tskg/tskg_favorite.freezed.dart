// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tskg_favorite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TskgFavorite {
  @HiveField(0)
  String get showId => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  int get episodeCount => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TskgFavoriteCopyWith<TskgFavorite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TskgFavoriteCopyWith<$Res> {
  factory $TskgFavoriteCopyWith(
          TskgFavorite value, $Res Function(TskgFavorite) then) =
      _$TskgFavoriteCopyWithImpl<$Res, TskgFavorite>;
  @useResult
  $Res call(
      {@HiveField(0) String showId,
      @HiveField(1) String name,
      @HiveField(2) int episodeCount,
      @HiveField(3) DateTime createdAt});
}

/// @nodoc
class _$TskgFavoriteCopyWithImpl<$Res, $Val extends TskgFavorite>
    implements $TskgFavoriteCopyWith<$Res> {
  _$TskgFavoriteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showId = null,
    Object? name = null,
    Object? episodeCount = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      showId: null == showId
          ? _value.showId
          : showId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      episodeCount: null == episodeCount
          ? _value.episodeCount
          : episodeCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TskgFavoriteCopyWith<$Res>
    implements $TskgFavoriteCopyWith<$Res> {
  factory _$$_TskgFavoriteCopyWith(
          _$_TskgFavorite value, $Res Function(_$_TskgFavorite) then) =
      __$$_TskgFavoriteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String showId,
      @HiveField(1) String name,
      @HiveField(2) int episodeCount,
      @HiveField(3) DateTime createdAt});
}

/// @nodoc
class __$$_TskgFavoriteCopyWithImpl<$Res>
    extends _$TskgFavoriteCopyWithImpl<$Res, _$_TskgFavorite>
    implements _$$_TskgFavoriteCopyWith<$Res> {
  __$$_TskgFavoriteCopyWithImpl(
      _$_TskgFavorite _value, $Res Function(_$_TskgFavorite) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showId = null,
    Object? name = null,
    Object? episodeCount = null,
    Object? createdAt = null,
  }) {
    return _then(_$_TskgFavorite(
      showId: null == showId
          ? _value.showId
          : showId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      episodeCount: null == episodeCount
          ? _value.episodeCount
          : episodeCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 0)
class _$_TskgFavorite extends _TskgFavorite {
  _$_TskgFavorite(
      {@HiveField(0) required this.showId,
      @HiveField(1) required this.name,
      @HiveField(2) this.episodeCount = 0,
      @HiveField(3) required this.createdAt})
      : super._();

  @override
  @HiveField(0)
  final String showId;
  @override
  @HiveField(1)
  final String name;
  @override
  @JsonKey()
  @HiveField(2)
  final int episodeCount;
  @override
  @HiveField(3)
  final DateTime createdAt;

  @override
  String toString() {
    return 'TskgFavorite(showId: $showId, name: $name, episodeCount: $episodeCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TskgFavorite &&
            (identical(other.showId, showId) || other.showId == showId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.episodeCount, episodeCount) ||
                other.episodeCount == episodeCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, showId, name, episodeCount, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TskgFavoriteCopyWith<_$_TskgFavorite> get copyWith =>
      __$$_TskgFavoriteCopyWithImpl<_$_TskgFavorite>(this, _$identity);
}

abstract class _TskgFavorite extends TskgFavorite {
  factory _TskgFavorite(
      {@HiveField(0) required final String showId,
      @HiveField(1) required final String name,
      @HiveField(2) final int episodeCount,
      @HiveField(3) required final DateTime createdAt}) = _$_TskgFavorite;
  _TskgFavorite._() : super._();

  @override
  @HiveField(0)
  String get showId;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  int get episodeCount;
  @override
  @HiveField(3)
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_TskgFavoriteCopyWith<_$_TskgFavorite> get copyWith =>
      throw _privateConstructorUsedError;
}
