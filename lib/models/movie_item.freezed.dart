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
  String get tag => throw _privateConstructorUsedError;

  /// идентификатор фильма или сериала
  @HiveField(1)
  String get id => throw _privateConstructorUsedError;

  /// название фильма или сериала
  @HiveField(2)
  String get name => throw _privateConstructorUsedError;

  /// постер фильма или сериала
  @HiveField(3)
  String get posterUrl => throw _privateConstructorUsedError;

  /// включены или выключены субтитры
  @HiveField(4)
  bool get subtitlesEnabled => throw _privateConstructorUsedError;

  /// включены или выключены субтитры
  @HiveField(4)
  set subtitlesEnabled(bool value) => throw _privateConstructorUsedError;

  /// дата последнего просмотра
  @HiveField(5)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// дата последнего просмотра
  @HiveField(5)
  set updatedAt(DateTime value) => throw _privateConstructorUsedError;

  /// список просмотренных эпизодов
  @HiveField(6)
  Map<String, SeenEpisode> get episodes => throw _privateConstructorUsedError;

  /// список просмотренных эпизодов
  @HiveField(6)
  set episodes(Map<String, SeenEpisode> value) =>
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
      {@HiveField(0) String tag,
      @HiveField(1) String id,
      @HiveField(2) String name,
      @HiveField(3) String posterUrl,
      @HiveField(4) bool subtitlesEnabled,
      @HiveField(5) DateTime updatedAt,
      @HiveField(6) Map<String, SeenEpisode> episodes});
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
    Object? tag = null,
    Object? id = null,
    Object? name = null,
    Object? posterUrl = null,
    Object? subtitlesEnabled = null,
    Object? updatedAt = null,
    Object? episodes = null,
  }) {
    return _then(_value.copyWith(
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
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
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as Map<String, SeenEpisode>,
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
      {@HiveField(0) String tag,
      @HiveField(1) String id,
      @HiveField(2) String name,
      @HiveField(3) String posterUrl,
      @HiveField(4) bool subtitlesEnabled,
      @HiveField(5) DateTime updatedAt,
      @HiveField(6) Map<String, SeenEpisode> episodes});
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
    Object? tag = null,
    Object? id = null,
    Object? name = null,
    Object? posterUrl = null,
    Object? subtitlesEnabled = null,
    Object? updatedAt = null,
    Object? episodes = null,
  }) {
    return _then(_$_MovieItem(
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
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
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as Map<String, SeenEpisode>,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 5)
class _$_MovieItem implements _MovieItem {
  _$_MovieItem(
      {@HiveField(0) required this.tag,
      @HiveField(1) required this.id,
      @HiveField(2) required this.name,
      @HiveField(3) required this.posterUrl,
      @HiveField(4) this.subtitlesEnabled = false,
      @HiveField(5) required this.updatedAt,
      @HiveField(6) this.episodes = const {}});

  /// идентификатор сайта
  @override
  @HiveField(0)
  final String tag;

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
  final String posterUrl;

  /// включены или выключены субтитры
  @override
  @JsonKey()
  @HiveField(4)
  bool subtitlesEnabled;

  /// дата последнего просмотра
  @override
  @HiveField(5)
  DateTime updatedAt;

  /// список просмотренных эпизодов
  @override
  @JsonKey()
  @HiveField(6)
  Map<String, SeenEpisode> episodes;

  @override
  String toString() {
    return 'MovieItem(tag: $tag, id: $id, name: $name, posterUrl: $posterUrl, subtitlesEnabled: $subtitlesEnabled, updatedAt: $updatedAt, episodes: $episodes)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieItemCopyWith<_$_MovieItem> get copyWith =>
      __$$_MovieItemCopyWithImpl<_$_MovieItem>(this, _$identity);
}

abstract class _MovieItem implements MovieItem {
  factory _MovieItem(
      {@HiveField(0) required final String tag,
      @HiveField(1) required final String id,
      @HiveField(2) required final String name,
      @HiveField(3) required final String posterUrl,
      @HiveField(4) bool subtitlesEnabled,
      @HiveField(5) required DateTime updatedAt,
      @HiveField(6) Map<String, SeenEpisode> episodes}) = _$_MovieItem;

  @override

  /// идентификатор сайта
  @HiveField(0)
  String get tag;
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
  @override

  /// включены или выключены субтитры
  @HiveField(4)
  bool get subtitlesEnabled;

  /// включены или выключены субтитры
  @HiveField(4)
  set subtitlesEnabled(bool value);
  @override

  /// дата последнего просмотра
  @HiveField(5)
  DateTime get updatedAt;

  /// дата последнего просмотра
  @HiveField(5)
  set updatedAt(DateTime value);
  @override

  /// список просмотренных эпизодов
  @HiveField(6)
  Map<String, SeenEpisode> get episodes;

  /// список просмотренных эпизодов
  @HiveField(6)
  set episodes(Map<String, SeenEpisode> value);
  @override
  @JsonKey(ignore: true)
  _$$_MovieItemCopyWith<_$_MovieItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EpisodeItem {
  /// идентификатор эпизода
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;

  /// название фильма или сериала
  @HiveField(2)
  String get name => throw _privateConstructorUsedError;

  /// время просмотра эпизода (в секундах)
  @HiveField(1)
  int get position => throw _privateConstructorUsedError;

  /// время просмотра эпизода (в секундах)
  @HiveField(1)
  set position(int value) => throw _privateConstructorUsedError;

  /// продолжительность эпизода (в секундах)
  @HiveField(2)
  int get duration => throw _privateConstructorUsedError;

  /// дата последнего просмотра
  @HiveField(5)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// дата последнего просмотра
  @HiveField(5)
  set updatedAt(DateTime value) => throw _privateConstructorUsedError;

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
      @HiveField(2) String name,
      @HiveField(1) int position,
      @HiveField(2) int duration,
      @HiveField(5) DateTime updatedAt});
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
    Object? updatedAt = null,
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
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      @HiveField(2) String name,
      @HiveField(1) int position,
      @HiveField(2) int duration,
      @HiveField(5) DateTime updatedAt});
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
    Object? updatedAt = null,
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
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 6)
class _$_EpisodeItem extends _EpisodeItem {
  _$_EpisodeItem(
      {@HiveField(0) required this.id,
      @HiveField(2) required this.name,
      @HiveField(1) this.position = 0,
      @HiveField(2) required this.duration,
      @HiveField(5) required this.updatedAt})
      : super._();

  /// идентификатор эпизода
  @override
  @HiveField(0)
  final String id;

  /// название фильма или сериала
  @override
  @HiveField(2)
  final String name;

  /// время просмотра эпизода (в секундах)
  @override
  @JsonKey()
  @HiveField(1)
  int position;

  /// продолжительность эпизода (в секундах)
  @override
  @HiveField(2)
  final int duration;

  /// дата последнего просмотра
  @override
  @HiveField(5)
  DateTime updatedAt;

  @override
  String toString() {
    return 'EpisodeItem(id: $id, name: $name, position: $position, duration: $duration, updatedAt: $updatedAt)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EpisodeItemCopyWith<_$_EpisodeItem> get copyWith =>
      __$$_EpisodeItemCopyWithImpl<_$_EpisodeItem>(this, _$identity);
}

abstract class _EpisodeItem extends EpisodeItem {
  factory _EpisodeItem(
      {@HiveField(0) required final String id,
      @HiveField(2) required final String name,
      @HiveField(1) int position,
      @HiveField(2) required final int duration,
      @HiveField(5) required DateTime updatedAt}) = _$_EpisodeItem;
  _EpisodeItem._() : super._();

  @override

  /// идентификатор эпизода
  @HiveField(0)
  String get id;
  @override

  /// название фильма или сериала
  @HiveField(2)
  String get name;
  @override

  /// время просмотра эпизода (в секундах)
  @HiveField(1)
  int get position;

  /// время просмотра эпизода (в секундах)
  @HiveField(1)
  set position(int value);
  @override

  /// продолжительность эпизода (в секундах)
  @HiveField(2)
  int get duration;
  @override

  /// дата последнего просмотра
  @HiveField(5)
  DateTime get updatedAt;

  /// дата последнего просмотра
  @HiveField(5)
  set updatedAt(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$_EpisodeItemCopyWith<_$_EpisodeItem> get copyWith =>
      throw _privateConstructorUsedError;
}
