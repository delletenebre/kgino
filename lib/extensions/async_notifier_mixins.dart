import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin ApiMixins<T> on AsyncNotifier<T> {
  ///Api get api => ref.read(apiProvider);

  Future<T?> apiRequest(
      Future<T> Function(CancelToken cancelToken) future) async {
    state = const AsyncLoading();

    /// отменяем выполнение запроса, если страница закрыта
    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);

    /// делаем запрос
    state = await AsyncValue.guard(() => future(cancelToken));

    return state.value;
  }
}
