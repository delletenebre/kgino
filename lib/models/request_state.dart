import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_state.freezed.dart';

@freezed
class RequestState<T> with _$RequestState {

  const RequestState._();
  
  const factory RequestState.empty() = _Empty;

  const factory RequestState.loading() = _Loading;

  const factory RequestState.success(T data) = _Success;

  const factory RequestState.error() = _Error;

  bool get isSuccess => this is _Success;
  
  bool get isError => this is _Error;
  
  bool get isEmpty => this is _Empty;
  
  bool get isLoading => this is _Loading;

  T get data => (this as _Success).data;

}
