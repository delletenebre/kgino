import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_state.freezed.dart';

@freezed
class RequestState<T> with _$RequestState {

  const RequestState._();
  
  const factory RequestState.empty() = _Empty;

  const factory RequestState.loading() = _Loading;

  const factory RequestState.success(T data) = _Success;

  const factory RequestState.error() = _Error;

  bool get success => this is _Success;
  
  bool get loading => this is _Loading;

  T get data => (this as _Success).data;

}
