// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'episode_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EpisodeItem {
  /// идентификатор эпизода
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;

  /// название эпизода
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;

  /// последняя позиция просмотра эпизода (в секундах)
  @HiveField(2)
  int get position => throw _privateConstructorUsedError;

  /// последняя позиция просмотра эпизода (в секундах)
  @HiveField(2)
  set position(int value) => throw _privateConstructorUsedError;

  /// продолжительность эпизода (в секундах)
  @HiveField(3)
  int get duration => throw _privateConstructorUsedError;

  /// дата последнего просмотра
  @HiveField(4)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// дата последнего просмотра
  @HiveField(4)
  set updatedAt(DateTime? value) => throw _privateConstructorUsedError;

  /// номер сезона
  @HiveField(5)
  int get seasonNumber => throw _privateConstructorUsedError;

  /// номер эпизода в сезоне
  @HiveField(6)
  int get episodeNumber => throw _privateConstructorUsedError;

  /// ссылка на проигрываемый файл
  String get streamUrl => throw _privateConstructorUsedError;

  /// ссылка на проигрываемый файл
  set streamUrl(String value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EpisodeItemCopyWith<EpisodeItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodeItemCopyWith<$Res> {
  factory $EpisodeItemCopyWith(
          EpisodeItem value, $Res Function(EpisodeItem) then) =
      _$EpisodeItemCopyWithImpl<$Res, EpisodeItem>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) int position,
      @HiveField(3) int duration,
      @HiveField(4) DateTime? updatedAt,
      @HiveField(5) int seasonNumber,
      @HiveField(6) int episodeNumber,
      String streamUrl});
}

/// @nodoc
class _$EpisodeItemCopyWithImpl<$Res, $Val extends EpisodeItem>
    implements $EpisodeItemCopyWith<$Res> {
  _$EpisodeItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? position = null,
    Object? duration = null,
    Object? updatedAt = freezed,
    Object? seasonNumber = null,
    Object? episodeNumber = null,
    Object? streamUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      episodeNumber: null == episodeNumber
          ? _value.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      streamUrl: null == streamUrl
          ? _value.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EpisodeItemCopyWith<$Res>
    implements $EpisodeItemCopyWith<$Res> {
  factory _$$_EpisodeItemCopyWith(
          _$_EpisodeItem value, $Res Function(_$_EpisodeItem) then) =
      __$$_EpisodeItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) int position,
      @HiveField(3) int duration,
      @HiveField(4) DateTime? updatedAt,
      @HiveField(5) int seasonNumber,
      @HiveField(6) int episodeNumber,
      String streamUrl});
}

/// @nodoc
class __$$_EpisodeItemCopyWithImpl<$Res>
    extends _$EpisodeItemCopyWithImpl<$Res, _$_EpisodeItem>
    implements _$$_EpisodeItemCopyWith<$Res> {
  __$$_EpisodeItemCopyWithImpl(
      _$_EpisodeItem _value, $Res Function(_$_EpisodeItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? position = null,
    Object? duration = null,
    Object? updatedAt = freezed,
    Object? seasonNumber = null,
    Object? episodeNumber = null,
    Object? streamUrl = null,
  }) {
    return _then(_$_EpisodeItem(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      episodeNumber: null == episodeNumber
          ? _value.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      streamUrl: null == streamUrl
          ? _value.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 6)
class _$_EpisodeItem extends _EpisodeItem {
  _$_EpisodeItem(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) this.position = 0,
      @HiveField(3) required this.duration,
      @HiveField(4) this.updatedAt,
      @HiveField(5) required this.seasonNumber,
      @HiveField(6) required this.episodeNumber,
      this.streamUrl = ''})
      : assert(duration > 0),
        super._();

  /// идентификатор эпизода
  @override
  @HiveField(0)
  final String id;

  /// название эпизода
  @override
  @HiveField(1)
  final String name;

  /// последняя позиция просмотра эпизода (в секундах)
  @override
  @JsonKey()
  @HiveField(2)
  int position;

  /// продолжительность эпизода (в секундах)
  @override
  @HiveField(3)
  final int duration;

  /// дата последнего просмотра
  @override
  @HiveField(4)
  DateTime? updatedAt;

  /// номер сезона
  @override
  @HiveField(5)
  final int seasonNumber;

  /// номер эпизода в сезоне
  @override
  @HiveField(6)
  final int episodeNumber;

  /// ссылка на проигрываемый файл
  @override
  @JsonKey()
  String streamUrl;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EpisodeItemCopyWith<_$_EpisodeItem> get copyWith =>
      __$$_EpisodeItemCopyWithImpl<_$_EpisodeItem>(this, _$identity);
}

abstract class _EpisodeItem extends EpisodeItem {
  factory _EpisodeItem(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) int position,
      @HiveField(3) required final int duration,
      @HiveField(4) DateTime? updatedAt,
      @HiveField(5) required final int seasonNumber,
      @HiveField(6) required final int episodeNumber,
      String streamUrl}) = _$_EpisodeItem;
  _EpisodeItem._() : super._();

  @override

  /// идентификатор эпизода
  @HiveField(0)
  String get id;
  @override

  /// название эпизода
  @HiveField(1)
  String get name;
  @override

  /// последняя позиция просмотра эпизода (в секундах)
  @HiveField(2)
  int get position;

  /// последняя позиция просмотра эпизода (в секундах)
  @HiveField(2)
  set position(int value);
  @override

  /// продолжительность эпизода (в секундах)
  @HiveField(3)
  int get duration;
  @override

  /// дата последнего просмотра
  @HiveField(4)
  DateTime? get updatedAt;

  /// дата последнего просмотра
  @HiveField(4)
  set updatedAt(DateTime? value);
  @override

  /// номер сезона
  @HiveField(5)
  int get seasonNumber;
  @override

  /// номер эпизода в сезоне
  @HiveField(6)
  int get episodeNumber;
  @override

  /// ссылка на проигрываемый файл
  String get streamUrl;

  /// ссылка на проигрываемый файл
  set streamUrl(String value);
  @override
  @JsonKey(ignore: true)
  _$$_EpisodeItemCopyWith<_$_EpisodeItem> get copyWith =>
      throw _privateConstructorUsedError;
}
