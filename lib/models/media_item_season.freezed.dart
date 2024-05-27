// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_item_season.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MediaItemSeason _$MediaItemSeasonFromJson(Map<String, dynamic> json) {
  return _MediaItemSeason.fromJson(json);
}

/// @nodoc
mixin _$MediaItemSeason {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<MediaItemEpisode> get episodes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MediaItemSeasonCopyWith<MediaItemSeason> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaItemSeasonCopyWith<$Res> {
  factory $MediaItemSeasonCopyWith(
          MediaItemSeason value, $Res Function(MediaItemSeason) then) =
      _$MediaItemSeasonCopyWithImpl<$Res, MediaItemSeason>;
  @useResult
  $Res call({String id, String name, List<MediaItemEpisode> episodes});
}

/// @nodoc
class _$MediaItemSeasonCopyWithImpl<$Res, $Val extends MediaItemSeason>
    implements $MediaItemSeasonCopyWith<$Res> {
  _$MediaItemSeasonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? episodes = null,
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
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<MediaItemEpisode>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaItemSeasonImplCopyWith<$Res>
    implements $MediaItemSeasonCopyWith<$Res> {
  factory _$$MediaItemSeasonImplCopyWith(_$MediaItemSeasonImpl value,
          $Res Function(_$MediaItemSeasonImpl) then) =
      __$$MediaItemSeasonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, List<MediaItemEpisode> episodes});
}

/// @nodoc
class __$$MediaItemSeasonImplCopyWithImpl<$Res>
    extends _$MediaItemSeasonCopyWithImpl<$Res, _$MediaItemSeasonImpl>
    implements _$$MediaItemSeasonImplCopyWith<$Res> {
  __$$MediaItemSeasonImplCopyWithImpl(
      _$MediaItemSeasonImpl _value, $Res Function(_$MediaItemSeasonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? episodes = null,
  }) {
    return _then(_$MediaItemSeasonImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      episodes: null == episodes
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<MediaItemEpisode>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaItemSeasonImpl extends _MediaItemSeason {
  const _$MediaItemSeasonImpl(
      {this.id = '',
      this.name = '',
      final List<MediaItemEpisode> episodes = const <MediaItemEpisode>[]})
      : _episodes = episodes,
        super._();

  factory _$MediaItemSeasonImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaItemSeasonImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  final List<MediaItemEpisode> _episodes;
  @override
  @JsonKey()
  List<MediaItemEpisode> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  @override
  String toString() {
    return 'MediaItemSeason(id: $id, name: $name, episodes: $episodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaItemSeasonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_episodes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaItemSeasonImplCopyWith<_$MediaItemSeasonImpl> get copyWith =>
      __$$MediaItemSeasonImplCopyWithImpl<_$MediaItemSeasonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaItemSeasonImplToJson(
      this,
    );
  }
}

abstract class _MediaItemSeason extends MediaItemSeason {
  const factory _MediaItemSeason(
      {final String id,
      final String name,
      final List<MediaItemEpisode> episodes}) = _$MediaItemSeasonImpl;
  const _MediaItemSeason._() : super._();

  factory _MediaItemSeason.fromJson(Map<String, dynamic> json) =
      _$MediaItemSeasonImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<MediaItemEpisode> get episodes;
  @override
  @JsonKey(ignore: true)
  _$$MediaItemSeasonImplCopyWith<_$MediaItemSeasonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
