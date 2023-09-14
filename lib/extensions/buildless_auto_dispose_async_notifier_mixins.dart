import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/filmix_api_provider.dart';

mixin StatesMixins<T> on AutoDisposeAsyncNotifier<T> {
  bool get isSuccess => !state.isLoading && !state.hasError && state.hasValue;
  bool get isLoading => state.isLoading;
}

mixin FilmixApiMixins<T> on AutoDisposeAsyncNotifier<T> {
  FilmixApi get api => ref.read(filmixApiProvider);
}

mixin ApiCallMixins<T> on AutoDisposeAsyncNotifier<T> {
  Future<T> apiCall(CancelToken? cancelToken);

  Future<T> fetch() async {
    /// отменяем выполнение запроса, если страница закрыта
    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);

    return await apiCall(
      cancelToken,
    );
  }
}
//   Future<void> updateData([PaginatorState? paginatorState]) async {
//     paginator = state.valueOrNull;

//     if (paginatorState != null) {
//       this.paginatorState = paginatorState;
//     }

//     /// if set const then Unhandled Exception: type 'AsyncData<Paginator<T>>' is
//     /// not a subtype of type 'AsyncValue<Never>' of 'previous'
//     // ignore: prefer_const_constructors
//     state = AsyncValue.loading();
//     state = await AsyncValue.guard(() => fetch());
//   }
// }

// mixin FormBuilderMixins<T> on BuildlessAutoDisposeAsyncNotifier<T> {
//   GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
//   FormBuilderState? get form => formKey.currentState;

//   /// получаем поле по ключу
//   FormBuilderFieldState? formField(String key) {
//     return form?.fields[key];
//   }

//   /// получаем поле по ключу
//   T formDataField<T>(String key) {
//     final formData = form?.data ?? {};
//     return formData[key] as T;
//   }

//   /// получаем значение поля формы по ключу
//   T formFieldValue<T>(String key) => form?.fields[key]?.value as T;
// }
