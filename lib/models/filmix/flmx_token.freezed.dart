// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flmx_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FlmxToken _$FlmxTokenFromJson(Map<String, dynamic> json) {
  return _FlmxToken.fromJson(json);
}

/// @nodoc
mixin _$FlmxToken {
  String get code => throw _privateConstructorUsedError;
  String get userCode => throw _privateConstructorUsedError;
  int get expire => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FlmxTokenCopyWith<FlmxToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlmxTokenCopyWith<$Res> {
  factory $FlmxTokenCopyWith(FlmxToken value, $Res Function(FlmxToken) then) =
      _$FlmxTokenCopyWithImpl<$Res, FlmxToken>;
  @useResult
  $Res call({String code, String userCode, int expire});
}

/// @nodoc
class _$FlmxTokenCopyWithImpl<$Res, $Val extends FlmxToken>
    implements $FlmxTokenCopyWith<$Res> {
  _$FlmxTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? userCode = null,
    Object? expire = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      userCode: null == userCode
          ? _value.userCode
          : userCode // ignore: cast_nullable_to_non_nullable
              as String,
      expire: null == expire
          ? _value.expire
          : expire // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FlmxTokenCopyWith<$Res> implements $FlmxTokenCopyWith<$Res> {
  factory _$$_FlmxTokenCopyWith(
          _$_FlmxToken value, $Res Function(_$_FlmxToken) then) =
      __$$_FlmxTokenCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String userCode, int expire});
}

/// @nodoc
class __$$_FlmxTokenCopyWithImpl<$Res>
    extends _$FlmxTokenCopyWithImpl<$Res, _$_FlmxToken>
    implements _$$_FlmxTokenCopyWith<$Res> {
  __$$_FlmxTokenCopyWithImpl(
      _$_FlmxToken _value, $Res Function(_$_FlmxToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? userCode = null,
    Object? expire = null,
  }) {
    return _then(_$_FlmxToken(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      userCode: null == userCode
          ? _value.userCode
          : userCode // ignore: cast_nullable_to_non_nullable
              as String,
      expire: null == expire
          ? _value.expire
          : expire // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_FlmxToken implements _FlmxToken {
  const _$_FlmxToken({this.code = '', this.userCode = '', this.expire = 0});

  factory _$_FlmxToken.fromJson(Map<String, dynamic> json) =>
      _$$_FlmxTokenFromJson(json);

  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final String userCode;
  @override
  @JsonKey()
  final int expire;

  @override
  String toString() {
    return 'FlmxToken(code: $code, userCode: $userCode, expire: $expire)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FlmxToken &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.userCode, userCode) ||
                other.userCode == userCode) &&
            (identical(other.expire, expire) || other.expire == expire));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, userCode, expire);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FlmxTokenCopyWith<_$_FlmxToken> get copyWith =>
      __$$_FlmxTokenCopyWithImpl<_$_FlmxToken>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FlmxTokenToJson(
      this,
    );
  }
}

abstract class _FlmxToken implements FlmxToken {
  const factory _FlmxToken(
      {final String code,
      final String userCode,
      final int expire}) = _$_FlmxToken;

  factory _FlmxToken.fromJson(Map<String, dynamic> json) =
      _$_FlmxToken.fromJson;

  @override
  String get code;
  @override
  String get userCode;
  @override
  int get expire;
  @override
  @JsonKey(ignore: true)
  _$$_FlmxTokenCopyWith<_$_FlmxToken> get copyWith =>
      throw _privateConstructorUsedError;
}
