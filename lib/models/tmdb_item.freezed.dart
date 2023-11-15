// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tmdb_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TmdbItem _$TmdbItemFromJson(Map<String, dynamic> json) {
  return _TmdbItem.fromJson(json);
}

/// @nodoc
mixin _$TmdbItem {
  String? get title => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  String get backdropPath => throw _privateConstructorUsedError;
  String get posterPath => throw _privateConstructorUsedError;
  String? get firstAirDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TmdbItemCopyWith<TmdbItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TmdbItemCopyWith<$Res> {
  factory $TmdbItemCopyWith(TmdbItem value, $Res Function(TmdbItem) then) =
      _$TmdbItemCopyWithImpl<$Res, TmdbItem>;
  @useResult
  $Res call(
      {String? title,
      String? name,
      String overview,
      String backdropPath,
      String posterPath,
      String? firstAirDate});
}

/// @nodoc
class _$TmdbItemCopyWithImpl<$Res, $Val extends TmdbItem>
    implements $TmdbItemCopyWith<$Res> {
  _$TmdbItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? name = freezed,
    Object? overview = null,
    Object? backdropPath = null,
    Object? posterPath = null,
    Object? firstAirDate = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
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
      firstAirDate: freezed == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TmdbItemImplCopyWith<$Res>
    implements $TmdbItemCopyWith<$Res> {
  factory _$$TmdbItemImplCopyWith(
          _$TmdbItemImpl value, $Res Function(_$TmdbItemImpl) then) =
      __$$TmdbItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? name,
      String overview,
      String backdropPath,
      String posterPath,
      String? firstAirDate});
}

/// @nodoc
class __$$TmdbItemImplCopyWithImpl<$Res>
    extends _$TmdbItemCopyWithImpl<$Res, _$TmdbItemImpl>
    implements _$$TmdbItemImplCopyWith<$Res> {
  __$$TmdbItemImplCopyWithImpl(
      _$TmdbItemImpl _value, $Res Function(_$TmdbItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? name = freezed,
    Object? overview = null,
    Object? backdropPath = null,
    Object? posterPath = null,
    Object? firstAirDate = freezed,
  }) {
    return _then(_$TmdbItemImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
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
      firstAirDate: freezed == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TmdbItemImpl extends _TmdbItem with DiagnosticableTreeMixin {
  const _$TmdbItemImpl(
      {this.title,
      this.name,
      this.overview = '',
      this.backdropPath = '',
      this.posterPath = '',
      this.firstAirDate})
      : super._();

  factory _$TmdbItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TmdbItemImplFromJson(json);

  @override
  final String? title;
  @override
  final String? name;
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
  final String? firstAirDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TmdbItem(title: $title, name: $name, overview: $overview, backdropPath: $backdropPath, posterPath: $posterPath, firstAirDate: $firstAirDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TmdbItem'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('overview', overview))
      ..add(DiagnosticsProperty('backdropPath', backdropPath))
      ..add(DiagnosticsProperty('posterPath', posterPath))
      ..add(DiagnosticsProperty('firstAirDate', firstAirDate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TmdbItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.firstAirDate, firstAirDate) ||
                other.firstAirDate == firstAirDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, name, overview,
      backdropPath, posterPath, firstAirDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TmdbItemImplCopyWith<_$TmdbItemImpl> get copyWith =>
      __$$TmdbItemImplCopyWithImpl<_$TmdbItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TmdbItemImplToJson(
      this,
    );
  }
}

abstract class _TmdbItem extends TmdbItem {
  const factory _TmdbItem(
      {final String? title,
      final String? name,
      final String overview,
      final String backdropPath,
      final String posterPath,
      final String? firstAirDate}) = _$TmdbItemImpl;
  const _TmdbItem._() : super._();

  factory _TmdbItem.fromJson(Map<String, dynamic> json) =
      _$TmdbItemImpl.fromJson;

  @override
  String? get title;
  @override
  String? get name;
  @override
  String get overview;
  @override
  String get backdropPath;
  @override
  String get posterPath;
  @override
  String? get firstAirDate;
  @override
  @JsonKey(ignore: true)
  _$$TmdbItemImplCopyWith<_$TmdbItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
