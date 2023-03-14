// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ApiResponse<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(T data) data,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(String message, Map<String, String> errors) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(T data)? data,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(String message, Map<String, String> errors)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(T data)? data,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(String message, Map<String, String> errors)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseIdle<T> value) idle,
    required TResult Function(ApiResponseData<T> value) data,
    required TResult Function(ApiResponseLoading<T> value) loading,
    required TResult Function(ApiResponseEmpty<T> value) empty,
    required TResult Function(ApiResponseError<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseIdle<T> value)? idle,
    TResult? Function(ApiResponseData<T> value)? data,
    TResult? Function(ApiResponseLoading<T> value)? loading,
    TResult? Function(ApiResponseEmpty<T> value)? empty,
    TResult? Function(ApiResponseError<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseIdle<T> value)? idle,
    TResult Function(ApiResponseData<T> value)? data,
    TResult Function(ApiResponseLoading<T> value)? loading,
    TResult Function(ApiResponseEmpty<T> value)? empty,
    TResult Function(ApiResponseError<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(
          ApiResponse<T> value, $Res Function(ApiResponse<T>) then) =
      _$ApiResponseCopyWithImpl<T, $Res, ApiResponse<T>>;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res, $Val extends ApiResponse<T>>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ApiResponseIdleCopyWith<T, $Res> {
  factory _$$ApiResponseIdleCopyWith(_$ApiResponseIdle<T> value,
          $Res Function(_$ApiResponseIdle<T>) then) =
      __$$ApiResponseIdleCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ApiResponseIdleCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseIdle<T>>
    implements _$$ApiResponseIdleCopyWith<T, $Res> {
  __$$ApiResponseIdleCopyWithImpl(
      _$ApiResponseIdle<T> _value, $Res Function(_$ApiResponseIdle<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiResponseIdle<T> extends ApiResponseIdle<T> {
  _$ApiResponseIdle() : super._();

  @override
  String toString() {
    return 'ApiResponse<$T>.idle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiResponseIdle<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(T data) data,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(String message, Map<String, String> errors) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(T data)? data,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(String message, Map<String, String> errors)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(T data)? data,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(String message, Map<String, String> errors)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseIdle<T> value) idle,
    required TResult Function(ApiResponseData<T> value) data,
    required TResult Function(ApiResponseLoading<T> value) loading,
    required TResult Function(ApiResponseEmpty<T> value) empty,
    required TResult Function(ApiResponseError<T> value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseIdle<T> value)? idle,
    TResult? Function(ApiResponseData<T> value)? data,
    TResult? Function(ApiResponseLoading<T> value)? loading,
    TResult? Function(ApiResponseEmpty<T> value)? empty,
    TResult? Function(ApiResponseError<T> value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseIdle<T> value)? idle,
    TResult Function(ApiResponseData<T> value)? data,
    TResult Function(ApiResponseLoading<T> value)? loading,
    TResult Function(ApiResponseEmpty<T> value)? empty,
    TResult Function(ApiResponseError<T> value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class ApiResponseIdle<T> extends ApiResponse<T> {
  factory ApiResponseIdle() = _$ApiResponseIdle<T>;
  ApiResponseIdle._() : super._();
}

/// @nodoc
abstract class _$$ApiResponseDataCopyWith<T, $Res> {
  factory _$$ApiResponseDataCopyWith(_$ApiResponseData<T> value,
          $Res Function(_$ApiResponseData<T>) then) =
      __$$ApiResponseDataCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$ApiResponseDataCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseData<T>>
    implements _$$ApiResponseDataCopyWith<T, $Res> {
  __$$ApiResponseDataCopyWithImpl(
      _$ApiResponseData<T> _value, $Res Function(_$ApiResponseData<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$ApiResponseData<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$ApiResponseData<T> extends ApiResponseData<T> {
  _$ApiResponseData(this.data) : super._();

  @override
  final T data;

  @override
  String toString() {
    return 'ApiResponse<$T>.data(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseData<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseDataCopyWith<T, _$ApiResponseData<T>> get copyWith =>
      __$$ApiResponseDataCopyWithImpl<T, _$ApiResponseData<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(T data) data,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(String message, Map<String, String> errors) error,
  }) {
    return data(this.data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(T data)? data,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(String message, Map<String, String> errors)? error,
  }) {
    return data?.call(this.data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(T data)? data,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(String message, Map<String, String> errors)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this.data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseIdle<T> value) idle,
    required TResult Function(ApiResponseData<T> value) data,
    required TResult Function(ApiResponseLoading<T> value) loading,
    required TResult Function(ApiResponseEmpty<T> value) empty,
    required TResult Function(ApiResponseError<T> value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseIdle<T> value)? idle,
    TResult? Function(ApiResponseData<T> value)? data,
    TResult? Function(ApiResponseLoading<T> value)? loading,
    TResult? Function(ApiResponseEmpty<T> value)? empty,
    TResult? Function(ApiResponseError<T> value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseIdle<T> value)? idle,
    TResult Function(ApiResponseData<T> value)? data,
    TResult Function(ApiResponseLoading<T> value)? loading,
    TResult Function(ApiResponseEmpty<T> value)? empty,
    TResult Function(ApiResponseError<T> value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class ApiResponseData<T> extends ApiResponse<T> {
  factory ApiResponseData(final T data) = _$ApiResponseData<T>;
  ApiResponseData._() : super._();

  T get data;
  @JsonKey(ignore: true)
  _$$ApiResponseDataCopyWith<T, _$ApiResponseData<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiResponseLoadingCopyWith<T, $Res> {
  factory _$$ApiResponseLoadingCopyWith(_$ApiResponseLoading<T> value,
          $Res Function(_$ApiResponseLoading<T>) then) =
      __$$ApiResponseLoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ApiResponseLoadingCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseLoading<T>>
    implements _$$ApiResponseLoadingCopyWith<T, $Res> {
  __$$ApiResponseLoadingCopyWithImpl(_$ApiResponseLoading<T> _value,
      $Res Function(_$ApiResponseLoading<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiResponseLoading<T> extends ApiResponseLoading<T> {
  _$ApiResponseLoading() : super._();

  @override
  String toString() {
    return 'ApiResponse<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiResponseLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(T data) data,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(String message, Map<String, String> errors) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(T data)? data,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(String message, Map<String, String> errors)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(T data)? data,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(String message, Map<String, String> errors)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseIdle<T> value) idle,
    required TResult Function(ApiResponseData<T> value) data,
    required TResult Function(ApiResponseLoading<T> value) loading,
    required TResult Function(ApiResponseEmpty<T> value) empty,
    required TResult Function(ApiResponseError<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseIdle<T> value)? idle,
    TResult? Function(ApiResponseData<T> value)? data,
    TResult? Function(ApiResponseLoading<T> value)? loading,
    TResult? Function(ApiResponseEmpty<T> value)? empty,
    TResult? Function(ApiResponseError<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseIdle<T> value)? idle,
    TResult Function(ApiResponseData<T> value)? data,
    TResult Function(ApiResponseLoading<T> value)? loading,
    TResult Function(ApiResponseEmpty<T> value)? empty,
    TResult Function(ApiResponseError<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ApiResponseLoading<T> extends ApiResponse<T> {
  factory ApiResponseLoading() = _$ApiResponseLoading<T>;
  ApiResponseLoading._() : super._();
}

/// @nodoc
abstract class _$$ApiResponseEmptyCopyWith<T, $Res> {
  factory _$$ApiResponseEmptyCopyWith(_$ApiResponseEmpty<T> value,
          $Res Function(_$ApiResponseEmpty<T>) then) =
      __$$ApiResponseEmptyCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ApiResponseEmptyCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseEmpty<T>>
    implements _$$ApiResponseEmptyCopyWith<T, $Res> {
  __$$ApiResponseEmptyCopyWithImpl(
      _$ApiResponseEmpty<T> _value, $Res Function(_$ApiResponseEmpty<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiResponseEmpty<T> extends ApiResponseEmpty<T> {
  _$ApiResponseEmpty() : super._();

  @override
  String toString() {
    return 'ApiResponse<$T>.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiResponseEmpty<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(T data) data,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(String message, Map<String, String> errors) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(T data)? data,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(String message, Map<String, String> errors)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(T data)? data,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(String message, Map<String, String> errors)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseIdle<T> value) idle,
    required TResult Function(ApiResponseData<T> value) data,
    required TResult Function(ApiResponseLoading<T> value) loading,
    required TResult Function(ApiResponseEmpty<T> value) empty,
    required TResult Function(ApiResponseError<T> value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseIdle<T> value)? idle,
    TResult? Function(ApiResponseData<T> value)? data,
    TResult? Function(ApiResponseLoading<T> value)? loading,
    TResult? Function(ApiResponseEmpty<T> value)? empty,
    TResult? Function(ApiResponseError<T> value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseIdle<T> value)? idle,
    TResult Function(ApiResponseData<T> value)? data,
    TResult Function(ApiResponseLoading<T> value)? loading,
    TResult Function(ApiResponseEmpty<T> value)? empty,
    TResult Function(ApiResponseError<T> value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class ApiResponseEmpty<T> extends ApiResponse<T> {
  factory ApiResponseEmpty() = _$ApiResponseEmpty<T>;
  ApiResponseEmpty._() : super._();
}

/// @nodoc
abstract class _$$ApiResponseErrorCopyWith<T, $Res> {
  factory _$$ApiResponseErrorCopyWith(_$ApiResponseError<T> value,
          $Res Function(_$ApiResponseError<T>) then) =
      __$$ApiResponseErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message, Map<String, String> errors});
}

/// @nodoc
class __$$ApiResponseErrorCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseError<T>>
    implements _$$ApiResponseErrorCopyWith<T, $Res> {
  __$$ApiResponseErrorCopyWithImpl(
      _$ApiResponseError<T> _value, $Res Function(_$ApiResponseError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? errors = null,
  }) {
    return _then(_$ApiResponseError<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

class _$ApiResponseError<T> extends ApiResponseError<T> {
  _$ApiResponseError(
      {this.message = '', final Map<String, String> errors = const {}})
      : _errors = errors,
        super._();

  @override
  @JsonKey()
  final String message;
  final Map<String, String> _errors;
  @override
  @JsonKey()
  Map<String, String> get errors {
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errors);
  }

  @override
  String toString() {
    return 'ApiResponse<$T>.error(message: $message, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseError<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseErrorCopyWith<T, _$ApiResponseError<T>> get copyWith =>
      __$$ApiResponseErrorCopyWithImpl<T, _$ApiResponseError<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(T data) data,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(String message, Map<String, String> errors) error,
  }) {
    return error(message, errors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(T data)? data,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(String message, Map<String, String> errors)? error,
  }) {
    return error?.call(message, errors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(T data)? data,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(String message, Map<String, String> errors)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, errors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiResponseIdle<T> value) idle,
    required TResult Function(ApiResponseData<T> value) data,
    required TResult Function(ApiResponseLoading<T> value) loading,
    required TResult Function(ApiResponseEmpty<T> value) empty,
    required TResult Function(ApiResponseError<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiResponseIdle<T> value)? idle,
    TResult? Function(ApiResponseData<T> value)? data,
    TResult? Function(ApiResponseLoading<T> value)? loading,
    TResult? Function(ApiResponseEmpty<T> value)? empty,
    TResult? Function(ApiResponseError<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiResponseIdle<T> value)? idle,
    TResult Function(ApiResponseData<T> value)? data,
    TResult Function(ApiResponseLoading<T> value)? loading,
    TResult Function(ApiResponseEmpty<T> value)? empty,
    TResult Function(ApiResponseError<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ApiResponseError<T> extends ApiResponse<T> {
  factory ApiResponseError(
      {final String message,
      final Map<String, String> errors}) = _$ApiResponseError<T>;
  ApiResponseError._() : super._();

  String get message;
  Map<String, String> get errors;
  @JsonKey(ignore: true)
  _$$ApiResponseErrorCopyWith<T, _$ApiResponseError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
