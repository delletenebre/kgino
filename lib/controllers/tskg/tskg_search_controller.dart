import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/tskg_api_provider.dart';
import '../../models/movie_item.dart';
import '../../models/request_state.dart';

export '../../models/request_state.dart';

class TskgSearchController extends Cubit<RequestState<List<MovieItem>>> {

  /// провайдер запросов к API
  final _api = GetIt.instance<TskgApiProvider>();

  TskgSearchController() : super(const RequestState.empty());

  Future<void> searchShows(String searchQuery) async {
    if (searchQuery.length > 2) {

      if (!state.isSuccess) {
        emit(const RequestState.loading());
      }

      try {
        /// запрашиваем фильмы по искомому запросу
        final shows = await _api.searchShows(searchQuery);
        if (!isClosed) {
          /// ^ если контроллер ещё существует
          
          if (shows.isEmpty) {
            /// ^ если данных нет
            emit(const RequestState.empty());
          
          } else {
            /// ^ если запрос выполнен успешно
            
            emit(RequestState.success(shows));
          }
        }

      } catch (exception) {
        debugPrint('TskgSearchController searchShows() exception: $exception');
      }
    }
  }

}
