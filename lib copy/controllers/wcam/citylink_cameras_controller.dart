
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../models/movie_item.dart';
import '../../../models/request_state.dart';
import '../../api/wcam_api_provider.dart';

export '../../../models/request_state.dart';

class CitylinkCamerasController extends Cubit<RequestState<List<MovieItem>>> {

  final String city;

  /// провайдер запросов к API
  final _api = GetIt.instance<WcamApiProvider>();

  /// текущая страница
  int _currentPage = 1;

  /// текущее количество загруженных элементов
  int _currentCount = 0;

  /// доступное количество элементов
  int _totalCount = 0;

  CitylinkCamerasController([this.city = '']) : super(const RequestState.loading()) {
    _api.getCitylinkTotalCount(city).then((totalCount) async {
      _totalCount = totalCount;

      if (_totalCount > 0) {
        fetchCameras();
      }
    });
  }

  Future<void> fetchCameras() async {
    final currentData = state.isSuccess ? state.data : [];

    if (currentData.length < _totalCount) {

      final cameras = await _api.getCitylinkCameras(
        city: city,
        page: _currentPage,
      );
      
      if (!isClosed) {
        if (cameras.isEmpty) {

        } else {
          /// ^ если данные получены успешно
          
          /// обновляем каталог
          final data = <MovieItem>[ ...currentData, ...cameras ];
          _currentPage++;

          emit(RequestState.success(data));
        }
      }

    }
  }

}
