import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/api_response.dart';
import '../models/kgino_item.dart';


class KginoItemDetailsCubit extends Cubit<ApiResponse<KginoItem>> {

  /// идентификатор контроля выполнения запросов
  CancelToken? _cancelToken;
  CancelToken? get cancelToken => _cancelToken;
  set cancelToken(CancelToken? cancelToken) {
    /// завершаем выполнение предыдущего запроса
    _cancelToken?.cancel();

    _cancelToken = cancelToken;
  }

  KginoItemDetailsCubit() : super(ApiResponse.empty());

  Future<void> fetch(Future<ApiResponse<KginoItem>> request) async {
    if (!isClosed) {
      emit(ApiResponse.loading());

      final response = await request;

      if (!isClosed) {
        emit(response);
      }
    }
    
  }

}
