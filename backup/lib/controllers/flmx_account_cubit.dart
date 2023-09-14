import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/flmx_api_provider.dart';
import '../models/api_response.dart';
import '../models/flmx/flmx_profile.dart';

class FlmxAccountCubit extends Cubit<ApiResponse<FlmxProfile>> {
  String userCode = '';

  /// провайдер запросов к API
  final api = GetIt.instance<FlmxApi>();

  FlmxAccountCubit() : super(ApiResponse.empty()) {
    getProfile();
  }

  Future<String> getCode() async {
    final response = await api.getToken();

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

    if (response.isError) {
      userCode = await getCode();
    }

    emit(response);
  }
}
