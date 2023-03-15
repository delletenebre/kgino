import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/flmx_api_provider.dart';
import '../../models/api_response.dart';
import '../../models/movie_item.dart';

export '../../models/request_state.dart';

class FlmxDetailsController extends Cubit<ApiResponse<MovieItem>> {
  final String id;

  /// провайдер запросов к API
  final _api = GetIt.instance<FlmxApiProvider>();

  FlmxDetailsController(this.id) : super(ApiResponse.loading());

  Future<void> fetchDetails() async {
    emit(ApiResponse.loading());

    /// отправляем запрос поиска фильма или сериала
    final response = await _api.getDetails(id);

    if (!isClosed) {
      emit(response);
    }
  }

}
