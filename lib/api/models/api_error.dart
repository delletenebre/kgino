import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

@Freezed(genericArgumentFactories: true)
class ApiError<T> with _$ApiError<T> implements Exception {
  const factory ApiError({
    @Default('') String message,
    @Default({}) Map<String, String> errors,
  }) = _ApiError;
}
