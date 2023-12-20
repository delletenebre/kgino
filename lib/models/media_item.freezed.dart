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
  switch (json['runtimeType']) {
    case 'tskg':
      return TskgItem.fromJson(json);
    case 'filmix':
      return FilmixItem.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'MediaItem',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$MediaItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title) tskg,
    required TResult Function(String id, String title) filmix,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title)? tskg,
    TResult? Function(String id, String title)? filmix,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title)? tskg,
    TResult Function(String id, String title)? filmix,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TskgItem value) tskg,
    required TResult Function(FilmixItem value) filmix,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TskgItem value)? tskg,
    TResult? Function(FilmixItem value)? filmix,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TskgItem value)? tskg,
    TResult Function(FilmixItem value)? filmix,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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
  $Res call({String id, String title});
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
    Object? id = null,
    Object? title = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TskgItemImplCopyWith<$Res>
    implements $MediaItemCopyWith<$Res> {
  factory _$$TskgItemImplCopyWith(
          _$TskgItemImpl value, $Res Function(_$TskgItemImpl) then) =
      __$$TskgItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title});
}

/// @nodoc
class __$$TskgItemImplCopyWithImpl<$Res>
    extends _$MediaItemCopyWithImpl<$Res, _$TskgItemImpl>
    implements _$$TskgItemImplCopyWith<$Res> {
  __$$TskgItemImplCopyWithImpl(
      _$TskgItemImpl _value, $Res Function(_$TskgItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$TskgItemImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TskgItemImpl extends TskgItem {
  const _$TskgItemImpl(this.id, this.title, {final String? $type})
      : $type = $type ?? 'tskg',
        super._();

  factory _$TskgItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TskgItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MediaItem.tskg(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TskgItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TskgItemImplCopyWith<_$TskgItemImpl> get copyWith =>
      __$$TskgItemImplCopyWithImpl<_$TskgItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title) tskg,
    required TResult Function(String id, String title) filmix,
  }) {
    return tskg(id, title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title)? tskg,
    TResult? Function(String id, String title)? filmix,
  }) {
    return tskg?.call(id, title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title)? tskg,
    TResult Function(String id, String title)? filmix,
    required TResult orElse(),
  }) {
    if (tskg != null) {
      return tskg(id, title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TskgItem value) tskg,
    required TResult Function(FilmixItem value) filmix,
  }) {
    return tskg(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TskgItem value)? tskg,
    TResult? Function(FilmixItem value)? filmix,
  }) {
    return tskg?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TskgItem value)? tskg,
    TResult Function(FilmixItem value)? filmix,
    required TResult orElse(),
  }) {
    if (tskg != null) {
      return tskg(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TskgItemImplToJson(
      this,
    );
  }
}

abstract class TskgItem extends MediaItem implements Database {
  const factory TskgItem(final String id, final String title) = _$TskgItemImpl;
  const TskgItem._() : super._();

  factory TskgItem.fromJson(Map<String, dynamic> json) =
      _$TskgItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$TskgItemImplCopyWith<_$TskgItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilmixItemImplCopyWith<$Res>
    implements $MediaItemCopyWith<$Res> {
  factory _$$FilmixItemImplCopyWith(
          _$FilmixItemImpl value, $Res Function(_$FilmixItemImpl) then) =
      __$$FilmixItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title});
}

/// @nodoc
class __$$FilmixItemImplCopyWithImpl<$Res>
    extends _$MediaItemCopyWithImpl<$Res, _$FilmixItemImpl>
    implements _$$FilmixItemImplCopyWith<$Res> {
  __$$FilmixItemImplCopyWithImpl(
      _$FilmixItemImpl _value, $Res Function(_$FilmixItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$FilmixItemImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FilmixItemImpl extends FilmixItem {
  const _$FilmixItemImpl(this.id, this.title, {final String? $type})
      : $type = $type ?? 'filmix',
        super._();

  factory _$FilmixItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilmixItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MediaItem.filmix(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilmixItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilmixItemImplCopyWith<_$FilmixItemImpl> get copyWith =>
      __$$FilmixItemImplCopyWithImpl<_$FilmixItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title) tskg,
    required TResult Function(String id, String title) filmix,
  }) {
    return filmix(id, title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title)? tskg,
    TResult? Function(String id, String title)? filmix,
  }) {
    return filmix?.call(id, title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title)? tskg,
    TResult Function(String id, String title)? filmix,
    required TResult orElse(),
  }) {
    if (filmix != null) {
      return filmix(id, title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TskgItem value) tskg,
    required TResult Function(FilmixItem value) filmix,
  }) {
    return filmix(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TskgItem value)? tskg,
    TResult? Function(FilmixItem value)? filmix,
  }) {
    return filmix?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TskgItem value)? tskg,
    TResult Function(FilmixItem value)? filmix,
    required TResult orElse(),
  }) {
    if (filmix != null) {
      return filmix(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FilmixItemImplToJson(
      this,
    );
  }
}

abstract class FilmixItem extends MediaItem implements Database {
  const factory FilmixItem(final String id, final String title) =
      _$FilmixItemImpl;
  const FilmixItem._() : super._();

  factory FilmixItem.fromJson(Map<String, dynamic> json) =
      _$FilmixItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$FilmixItemImplCopyWith<_$FilmixItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
