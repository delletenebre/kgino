// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'season_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeasonItem {
  /// название сезона
  String get name => throw _privateConstructorUsedError;

  /// список эпизодов
  List<EpisodeItem> get episodes => throw _privateConstructorUsedError;

  /// список эпизодов
  set episodes(List<EpisodeItem> value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeasonItemCopyWith<SeasonItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonItemCopyWith<$Res> {
  factory $SeasonItemCopyWith(
          SeasonItem value, $Res Function(SeasonItem) then) =
      _$SeasonItemCopyWithImpl<$Res, SeasonItem>;
  @useResult
  $Res call({String name, List<EpisodeItem> episodes});
}

/// @nodoc
class _$SeasonItemCopyWithImpl<$Res, $Val extends SeasonItem>
    implements $SeasonItemCopyWith<$Res> {
  _$SeasonItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? episodes = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<EpisodeItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SeasonItemCopyWith<$Res>
    implements $SeasonItemCopyWith<$Res> {
  factory _$$_SeasonItemCopyWith(
          _$_SeasonItem value, $Res Function(_$_SeasonItem) then) =
      __$$_SeasonItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<EpisodeItem> episodes});
}

/// @nodoc
class __$$_SeasonItemCopyWithImpl<$Res>
    extends _$SeasonItemCopyWithImpl<$Res, _$_SeasonItem>
    implements _$$_SeasonItemCopyWith<$Res> {
  __$$_SeasonItemCopyWithImpl(
      _$_SeasonItem _value, $Res Function(_$_SeasonItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? episodes = null,
  }) {
    return _then(_$_SeasonItem(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<EpisodeItem>,
    ));
  }
}

/// @nodoc

class _$_SeasonItem extends _SeasonItem {
  _$_SeasonItem({this.name = '', this.episodes = const []}) : super._();

  /// название сезона
  @override
  @JsonKey()
  final String name;

  /// список эпизодов
  @override
  @JsonKey()
  List<EpisodeItem> episodes;

  @override
  String toString() {
    return 'SeasonItem(name: $name, episodes: $episodes)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeasonItemCopyWith<_$_SeasonItem> get copyWith =>
      __$$_SeasonItemCopyWithImpl<_$_SeasonItem>(this, _$identity);
}

abstract class _SeasonItem extends SeasonItem {
  factory _SeasonItem({final String name, List<EpisodeItem> episodes}) =
      _$_SeasonItem;
  _SeasonItem._() : super._();

  @override

  /// название сезона
  String get name;
  @override

  /// список эпизодов
  List<EpisodeItem> get episodes;

  /// список эпизодов
  set episodes(List<EpisodeItem> value);
  @override
  @JsonKey(ignore: true)
  _$$_SeasonItemCopyWith<_$_SeasonItem> get copyWith =>
      throw _privateConstructorUsedError;
}
