// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filmix_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FilmixToken _$FilmixTokenFromJson(Map<String, dynamic> json) {
  return _FilmixToken.fromJson(json);
}

/// @nodoc
mixin _$FilmixToken {
  String get code => throw _privateConstructorUsedError;
  String get userCode => throw _privateConstructorUsedError;
  int get expire => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilmixTokenCopyWith<FilmixToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilmixTokenCopyWith<$Res> {
  factory $FilmixTokenCopyWith(
          FilmixToken value, $Res Function(FilmixToken) then) =
      _$FilmixTokenCopyWithImpl<$Res, FilmixToken>;
  @useResult
  $Res call({String code, String userCode, int expire});
}

/// @nodoc
class _$FilmixTokenCopyWithImpl<$Res, $Val extends FilmixToken>
    implements $FilmixTokenCopyWith<$Res> {
  _$FilmixTokenCopyWithImpl(this._value, this._then);

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
abstract class _$$FilmixTokenImplCopyWith<$Res>
    implements $FilmixTokenCopyWith<$Res> {
  factory _$$FilmixTokenImplCopyWith(
          _$FilmixTokenImpl value, $Res Function(_$FilmixTokenImpl) then) =
      __$$FilmixTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String userCode, int expire});
}

/// @nodoc
class __$$FilmixTokenImplCopyWithImpl<$Res>
    extends _$FilmixTokenCopyWithImpl<$Res, _$FilmixTokenImpl>
    implements _$$FilmixTokenImplCopyWith<$Res> {
  __$$FilmixTokenImplCopyWithImpl(
      _$FilmixTokenImpl _value, $Res Function(_$FilmixTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? userCode = null,
    Object? expire = null,
  }) {
    return _then(_$FilmixTokenImpl(
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
class _$FilmixTokenImpl implements _FilmixToken {
  const _$FilmixTokenImpl(
      {this.code = '', this.userCode = '', this.expire = 0});

  factory _$FilmixTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilmixTokenImplFromJson(json);

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
    return 'FilmixToken(code: $code, userCode: $userCode, expire: $expire)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilmixTokenImpl &&
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
  _$$FilmixTokenImplCopyWith<_$FilmixTokenImpl> get copyWith =>
      __$$FilmixTokenImplCopyWithImpl<_$FilmixTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilmixTokenImplToJson(
      this,
    );
  }
}

abstract class _FilmixToken implements FilmixToken {
  const factory _FilmixToken(
      {final String code,
      final String userCode,
      final int expire}) = _$FilmixTokenImpl;

  factory _FilmixToken.fromJson(Map<String, dynamic> json) =
      _$FilmixTokenImpl.fromJson;

  @override
  String get code;
  @override
  String get userCode;
  @override
  int get expire;
  @override
  @JsonKey(ignore: true)
  _$$FilmixTokenImplCopyWith<_$FilmixTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
