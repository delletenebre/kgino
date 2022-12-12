
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../models/movie_item.dart';
import '../../../models/request_state.dart';
import '../../api/wcam_api_provider.dart';

export '../../../models/request_state.dart';

class KtCamerasController extends Cubit<RequestState<List<MovieItem>>> {

  /// провайдер запросов к API
  final _api = GetIt.instance<WcamApiProvider>();

  KtCamerasController() : super(const RequestState.loading()) {
    _api.getKtCameras().then((items) {
      if (!isClosed) {
        if (items.isEmpty) {
          /// ^ если данных нет
          emit(const RequestState.empty());
        } else {
          /// ^ если данные получены успешно
          emit(RequestState.success(items));
        }
      }
    });
    
  }

}
