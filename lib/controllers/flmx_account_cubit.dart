
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../api/flmx_api_provider.dart';
import '../models/api_response.dart';
import '../models/flmx/flmx_profile.dart';

class FlmxAccountCubit extends Cubit<ApiResponse<FlmxProfile>> {

  /// провайдер запросов к API
  final api = GetIt.instance<FlmxApiProvider>();
    
  FlmxAccountCubit() : super(ApiResponse.empty()) {
    getProfile();
  }

  Future<String> getCode() async {
    emit(ApiResponse.loading());

    final response = await api.getToken();

    emit(ApiResponse.empty());

    if (response.isSuccess) {
      return response.asData.data.userCode;
    }

    return '';
  }

  Future<void> getProfile() async {
    emit(ApiResponse.loading());

    final response = await api.getProfile();

    if (isClosed) {
      return;
    }

    emit(response);
  }

  
}
