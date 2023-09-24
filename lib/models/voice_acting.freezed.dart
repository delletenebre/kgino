// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_acting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VoiceActing _$VoiceActingFromJson(Map<String, dynamic> json) {
  return _VoiceActing.fromJson(json);
}

/// @nodoc
mixin _$VoiceActing {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoiceActingCopyWith<VoiceActing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceActingCopyWith<$Res> {
  factory $VoiceActingCopyWith(
          VoiceActing value, $Res Function(VoiceActing) then) =
      _$VoiceActingCopyWithImpl<$Res, VoiceActing>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$VoiceActingCopyWithImpl<$Res, $Val extends VoiceActing>
    implements $VoiceActingCopyWith<$Res> {
  _$VoiceActingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VoiceActingCopyWith<$Res>
    implements $VoiceActingCopyWith<$Res> {
  factory _$$_VoiceActingCopyWith(
          _$_VoiceActing value, $Res Function(_$_VoiceActing) then) =
      __$$_VoiceActingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$_VoiceActingCopyWithImpl<$Res>
    extends _$VoiceActingCopyWithImpl<$Res, _$_VoiceActing>
    implements _$$_VoiceActingCopyWith<$Res> {
  __$$_VoiceActingCopyWithImpl(
      _$_VoiceActing _value, $Res Function(_$_VoiceActing) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$_VoiceActing(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VoiceActing implements _VoiceActing {
  const _$_VoiceActing({this.id = '', this.name = ''});

  factory _$_VoiceActing.fromJson(Map<String, dynamic> json) =>
      _$$_VoiceActingFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'VoiceActing(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VoiceActing &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VoiceActingCopyWith<_$_VoiceActing> get copyWith =>
      __$$_VoiceActingCopyWithImpl<_$_VoiceActing>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VoiceActingToJson(
      this,
    );
  }
}

abstract class _VoiceActing implements VoiceActing {
  const factory _VoiceActing({final String id, final String name}) =
      _$_VoiceActing;

  factory _VoiceActing.fromJson(Map<String, dynamic> json) =
      _$_VoiceActing.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_VoiceActingCopyWith<_$_VoiceActing> get copyWith =>
      throw _privateConstructorUsedError;
}
