import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/flmx_api_provider.dart';
import '../../models/api_response.dart';
import '../../models/movie_item.dart';

export '../../models/request_state.dart';

class FlmxSearchController extends Cubit<ApiResponse<List<MovieItem>>> {

  /// провайдер запросов к API
  final _api = GetIt.instance<FlmxApiProvider>();

  FlmxSearchController() : super(ApiResponse.empty());

  Future<void> search(String searchQuery) async {
    if (searchQuery.length > 2) {

      if (!state.isSuccess) {
        emit(ApiResponse.loading());
      }

      /// отправляем запрос поиска фильма или сериала
      final response = await _api.search(searchQuery);

      if (!isClosed) {
        emit(response);
      }
    }
  }

}
