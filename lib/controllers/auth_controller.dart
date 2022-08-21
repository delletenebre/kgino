// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';

// import '../api/api_provider.dart';
// import '../models/user_profile.dart';


// class AuthController extends GetxController with StateMixin<UserProfile> {
//   /// защищённое хранилище
//   final _storage = const FlutterSecureStorage(
    
//     /// включаем использование EncryptedSharedPreferences на Android
//     aOptions: AndroidOptions(
//       encryptedSharedPreferences: true,
//     ),
    
//   );

//   /// ключ доступа к API
//   final _accessToken = ''.obs;
//   String get accessToken => _accessToken.value;

//   @override
//   Future<void> onInit() async {
//     /// изменяем статус контроллера
//     change(GetStatus.loading());

//     _accessToken.value = await _storage.read(key: 'accessToken') ?? '';

//     if (accessToken.isNotEmpty) {
//       /// ^ если ключ доступа сохранён в системе
      
//       /// обновляем профиль пользователя
//       updateUserProfile();
    
//     } else {
//       /// ^ если ключ доступа не сохранён в системе
    
//       /// меняем статус контроллера на отсутствие авторизации
//       change(GetStatus.empty());
//     }

//     /// при изменении параметров - записываем значения на диск
//     ever(_accessToken, (String value) async {
//       await _storage.write(key: 'accessToken', value: value);
//     });

//     super.onInit();
//   }

//   /// обновление ключей авторизации
//   void updateTokens(String accessToken) {
    
//     /// обновляем ключ авторизации
//     _accessToken.value = accessToken;

//     if (accessToken.isEmpty) {
//       /// ^ если ключ авторизации пуст

//       /// выход из профиля
//       change(GetStatus.empty());

//     } else {
//       /// ^ если ключи авторизации присутствуют

//       final api = Get.find<ApiProvider>();

//       /// обновляем ключ авторизации для провайдера API
//       api.updateAuthorization(accessToken);

//       /// обновляем профиль пользователя
//       updateUserProfile();
//     }
//   }

//   Future<void> login(String login, String password) async {
//     /// меняем статус контроллера
//     change(GetStatus.loading());

//     final apiProvider = Get.find<ApiProvider>();
//     final response = await apiProvider.login(login, password);

//     if (response.isOk) {
//       /// ^ если запрос выполнен успешно
      
//       /// получаем ключ авторизации
//       final accessToken = response.body['token'];

//       /// обновляем ключ авторизации
//       updateTokens(accessToken);
    
//     } else {
//       /// ^ если при выполнении запроса произошла ошибка
      
//       /// изменяем статус контроллера
//       change(GetStatus.error('Ошибка авторизации. Пользователь с указанными реквизитами не найден'));
//     }

//   }

//   Future<void> logout() async {
//     /// обновляем ключи авторизации
//     updateTokens('');
//   }

//   Future<void> updateUserProfile() async {
//     /// изменяем статус контроллера
//     change(GetStatus.empty());

//     final api = Get.find<ApiProvider>();
    
//     /// получаем профиль пользователя
//     final response = await api.getUserProfile();

//     if (response.isOk) {
//       /// ^ если запрос выполнен успешно
    
//       /// считываем профиль пользователя
//       final userProfile = response.body;

//       /// меняем статус контроллера
//       change(GetStatus.success(userProfile));
    
//     } else {
//       /// ^ если при запросе данных пользователя произошла ошибка

//       /// меняем статус контроллера
//       change(GetStatus.error('Нет доступа к сети Интернет'));

//     }
//   }
// }