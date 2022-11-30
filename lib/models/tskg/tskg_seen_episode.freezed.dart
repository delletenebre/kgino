// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tskg_seen_episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TskgSeenEpisode {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @HiveField(1)
  int get position => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TskgSeenEpisodeCopyWith<TskgSeenEpisode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TskgSeenEpisodeCopyWith<$Res> {
  factory $TskgSeenEpisodeCopyWith(
          TskgSeenEpisode value, $Res Function(TskgSeenEpisode) then) =
      _$TskgSeenEpisodeCopyWithImpl<$Res, TskgSeenEpisode>;
  @useResult
  $Res call({@HiveField(0) int id, @HiveField(1) int position});
}

/// @nodoc
class _$TskgSeenEpisodeCopyWithImpl<$Res, $Val extends TskgSeenEpisode>
    implements $TskgSeenEpisodeCopyWith<$Res> {
  _$TskgSeenEpisodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TskgSeenEpisodeCopyWith<$Res>
    implements $TskgSeenEpisodeCopyWith<$Res> {
  factory _$$_TskgSeenEpisodeCopyWith(
          _$_TskgSeenEpisode value, $Res Function(_$_TskgSeenEpisode) then) =
      __$$_TskgSeenEpisodeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) int id, @HiveField(1) int position});
}

/// @nodoc
class __$$_TskgSeenEpisodeCopyWithImpl<$Res>
    extends _$TskgSeenEpisodeCopyWithImpl<$Res, _$_TskgSeenEpisode>
    implements _$$_TskgSeenEpisodeCopyWith<$Res> {
  __$$_TskgSeenEpisodeCopyWithImpl(
      _$_TskgSeenEpisode _value, $Res Function(_$_TskgSeenEpisode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
  }) {
    return _then(_$_TskgSeenEpisode(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 1)
class _$_TskgSeenEpisode extends _TskgSeenEpisode {
  _$_TskgSeenEpisode(
      {@HiveField(0) this.id = 0, @HiveField(1) this.position = 0})
      : super._();

  @override
  @JsonKey()
  @HiveField(0)
  final int id;
  @override
  @JsonKey()
  @HiveField(1)
  final int position;

  @override
  String toString() {
    return 'TskgSeenEpisode(id: $id, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TskgSeenEpisode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TskgSeenEpisodeCopyWith<_$_TskgSeenEpisode> get copyWith =>
      __$$_TskgSeenEpisodeCopyWithImpl<_$_TskgSeenEpisode>(this, _$identity);
}

abstract class _TskgSeenEpisode extends TskgSeenEpisode {
  factory _TskgSeenEpisode(
      {@HiveField(0) final int id,
      @HiveField(1) final int position}) = _$_TskgSeenEpisode;
  _TskgSeenEpisode._() : super._();

  @override
  @HiveField(0)
  int get id;
  @override
  @HiveField(1)
  int get position;
  @override
  @JsonKey(ignore: true)
  _$$_TskgSeenEpisodeCopyWith<_$_TskgSeenEpisode> get copyWith =>
      throw _privateConstructorUsedError;
}
