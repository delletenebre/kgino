import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';


class ApiProvider extends GetConnect {

  //final authController = Get.find<AuthController>();

  @override
  Future<void> onInit() async {
    
    // httpClient.baseUrl = 'http://217.29.18.146:5005';
    httpClient.baseUrl = 'http://172.30.0.9:5005/api/v1';
    // httpClient.baseUrl = 'https://ds.edu.gov.kg/api/v1';

    /// добавляем заголовок Authorization
    // httpClient.addRequestModifier((Request request) {
    //   final accessToken = authController.accessToken;
    //   request.headers['Authorization'] = 'Bearer_$accessToken';
    //   return request;
    // });

    /// включаем отладочные логи запросов
    httpClient.addResponseModifier((request, response) {
      debugPrint('==== ==== ==== ====');
      debugPrint('request url: ${request.method} ${request.url}');
      debugPrint('request headers: ${request.headers}');
      debugPrint('response code: ${response.status.code}');
      debugPrint('response body: ${response.body}');
      debugPrint('==== ==== ==== ====');
      return response;
    });

    // Even if the server sends data from the country "Brazil",
    // it will never be displayed to users, because you remove
    // that data from the response, even before the response is delivered
    // httpClient.addResponseModifier<CasesModel>((request, response) {
    //   CasesModel model = response.body;
    //   if (model.countries.contains('Brazil')) {
    //     model.countries.remove('Brazilll');
    //   }
    // });

    // httpClient.addAuthenticator((Request request) async {
    //   final accessToken = authController.user.accessToken;

    //   request.headers['Authorization'] = 'Bearer $accessToken';
      
    //   return request;
    // });

    /// Autenticator will be called 3 times if HttpStatus is
    /// HttpStatus.unauthorized
    httpClient.maxAuthRetries = 3;

    super.onInit();
  }

  void updateAuthorization(String accessToken) {
    /// добавляем заголовок Authorization
    httpClient.addRequestModifier((Request request) {
      request.headers['Authorization'] = 'Bearer_$accessToken';
      return request;
    });
  }

  Future<Response> login(String login, String password) async {
    final body = {
      'username': login,
      'password': password,
    };

    return await post('/auth/login', body,
      // decoder: (response) {
      //   debugPrint(response.toString());
      //   try {
      //     final user = response['user'];
      //     final roles = response['roles'];
      //     final token = response['token'];
          
      //     return User.fromJson(user..addAll(
      //       {
      //         'token': token,
      //         'roles': roles,
      //       }
      //     ));

      //   } catch (exception) {
          
      //     return response;
      //   }
      // }
    );
  }

  // Future<Response> changePassword(
  //   String currentPassword,
  //   String newPassword,
  //   String confirmPassword
  // ) async {
  //   final body = {
  //     'pageSize': currentPassword,
  //   };

  //   return await post('/agency/policy/', body);
  // }

  // /// получение профиля пользователя
  // Future<Response> getUserProfile() async {
  //   return await get('/users/profile',
  //     decoder: (response) {
  //       try {
  //         return UserProfile.fromJson(response);
  //       } catch (exception) {
  //         exception.printError();
  //         return response;
  //       }
  //     }
  //   );
  // }

  // /// АГЕНТ: поиск по списку полисов
  // Future<Response> agentSearchPolicies({
  //   int page = 1,
  //   int pageSize = 100,
  //   Map<String, String> filter = const {},
  // }) async {
  //   final body = {
  //     'pageSize': pageSize,
  //   };

  //   return await post('/agency/policy/list', body, query: {
  //     'page': page,
  //   });
  // }
}
