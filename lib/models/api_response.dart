import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  ApiResponse._();

  factory ApiResponse.data(T data) = ApiResponseData<T>;

  // factory ApiResponse.verified(T data) = ApiResponseVerified<T>;

  factory ApiResponse.loading() = ApiResponseLoading;

  factory ApiResponse.empty() = ApiResponseEmpty;

  factory ApiResponse.error({
    @Default('') String message,
    @Default({}) Map<String, String> errors,
  }) = ApiResponseError;

  ApiResponseError get asError => this as ApiResponseError;
  ApiResponseData<T> get asData => this as ApiResponseData<T>;

  bool get isSuccess => this is ApiResponseData;
  bool get isLoading => this is ApiResponseLoading;
  bool get isEmpty => this is ApiResponseEmpty;
  bool get isError => this is ApiResponseError;


  Map<String, K> toOptions<K>(
    String Function(K item) getId,
  ) {
    if (isSuccess) {
      final data = asData.data;
      if (data is List) {
        return { for (final item in data) getId(item) : item };
      }
    }

    return {};
  }
}
