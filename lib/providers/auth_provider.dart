// import 'package:einsurance/extensions/form_builder_state_extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../api/api_provider.dart';
// import '../extensions/riverpod_mixins.dart';
// import '../models/user.dart';
// import 'providers.dart';

// part 'auth_provider.g.dart';

// @Riverpod(keepAlive: true)
// /// контроллер языка приложения
// class Auth extends _$Auth with FormMixins {

//   /// ключ в хранилище
//   static const _prefsKey = 'tokens';

//   /// авторизован ли пользователь
//   bool get isAuthenticated => state.hasValue && state.value != null
//     && !state.hasError && !state.isLoading;
  
//   /// получаем пользователя, если он авторизован
//   User? get user => state.asData?.value;

//   /// если пользователь администратор
//   bool get isRoot => user?.role.isRoot ?? false;

//   /// если пользователь администратор
//   bool get isAdmin => user?.role.isAdministrator ?? false;

//   /// если пользователь менеджер
//   bool get isManager => user?.role.isManager ?? false;

//   /// если пользователь агент
//   bool get isAgent => user?.role.isAgent ?? false;

//   @override
//   FutureOr<User?> build() async {
//     getProfile();

//     return null;
//   }

//   /// получаем профиль пользователя
//   FutureOr<User?> getProfile() async {
//     state = const AsyncLoading();

//     /// провайдер запросов к API
//     final api = ref.read(apiProvider);

//     state = await AsyncValue.guard(() async {
//       /// пробуем получить данные пользователя
//       final response = await api.getMe();

//       return response;
//     });

//     return state.value;
//   }

//   Future<void> signin() async {
//     state = const AsyncLoading();

//     /// провайдер запросов к API
//     final api = ref.read(apiProvider);

//     /// отменяем выполнение запроса, если страница закрыта
//     final cancelToken = CancelToken();
//     ref.onDispose(cancelToken.cancel);

//     /// очищаем ошибки с полей формы
//     form?.saveAndValidate();

//     final tokens = await AsyncValue.guard(() async {
//       /// отправляем запрос на выдачу номеров БСО ОСАГО
//       final response = await api.signin(form?.data ?? {},
//         cancelToken: cancelToken,
//       );

//       /// хранилище данных
//       final storage = ref.read(storageProvider);

//       /// сохраняем ключи авторизации
//       await storage.writeSecure(_prefsKey, response.toJson());

//       return response;
//     });

//     if (tokens.hasError) {
//       /// заполняем ошибки валидации формы
//       form.setFieldErrors(tokens.error!);
//       state = AsyncError(tokens.error!, StackTrace.empty);
    
//     } else {
//       /// ^ если ошибок при входе в аккаунт нет
      
//       /// обновляем профиль пользователя
//       await getProfile();
    
//     }

//   }

//   /// выход из аккаунта
//   FutureOr<void> signout() async {
//     /// хранилище данных
//     final storage = ref.read(storageProvider);

//     /// очищаем хранилище
//     await storage.removeSecure(_prefsKey);

//     state = AsyncValue.error(UnauthenticatedState(), StackTrace.empty);
//   }
// }

// class UnauthenticatedState {
// }
