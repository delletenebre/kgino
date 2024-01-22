import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/filmix_api_provider.dart';
import '../models/filmix/filmix_profile.dart';

part 'filmix_auth_provider.g.dart';

/// контроллер авторизации
@Riverpod(keepAlive: true)
class FilmixAuth extends _$FilmixAuth {
  /// ключ в хранилище
  static const prefsKey = 'tokens';

  String userCode = '';

  /// авторизован ли пользователь
  bool isAuthenticated() =>
      state.hasValue &&
      state.value != null &&
      !state.hasError &&
      !state.isLoading;

  @override
  FutureOr<FilmixProfile?> build() async {
    return getProfile();
  }

  /// получаем профиль пользователя
  FutureOr<FilmixProfile?> getProfile() async {
    state = const AsyncLoading();
    print('HERE');

    /// провайдер запросов к API
    final api = ref.read(filmixApiProvider);

    state = await AsyncValue.guard(() async {
      /// пробуем получить данные пользователя
      final response = await api.getProfile();

      return response;
    });

    if (state.hasError) {
      userCode = await getCode();
    }

    return state.value;
  }

  Future<String> getCode() async {
    state = const AsyncLoading();

    /// провайдер запросов к API
    final api = ref.read(filmixApiProvider);

    try {
      final response = await api.getToken();
      userCode = response.userCode;
      return userCode;
    } catch (exception) {
      return '';
    }
  }
}
