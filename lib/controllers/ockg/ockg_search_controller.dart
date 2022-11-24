import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/ockg_api_provider.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../models/request_state.dart';

export '../../models/request_state.dart';

class OckgSearchController extends Cubit<RequestState<List<OckgMovie>>> {

  /// провайдер запросов к API
  final _api = GetIt.instance<OckgApiProvider>();

  OckgSearchController() : super(const RequestState.empty());

  Future<void> searchMovies(String searchQuery) async {
    if (searchQuery.length > 2) {

      if (!state.isSuccess) {
        emit(const RequestState.loading());
      }

      try {

        /// запрашиваем фильмы по искомому запросу
        final movies = await _api.searchMovies(searchQuery);

        if (!isClosed) {
          /// ^ если контроллер ещё существует
          
          if (movies.isEmpty) {
            /// ^ если данных нет
            emit(const RequestState.empty());
          
          } else {
            /// ^ если запрос выполнен успешно
            
            emit(RequestState.success(movies));
          }
        }

      } catch (exception) {
        debugPrint('OckgSearchController searchMovies() exception: $exception');
      }
    }
  }

}
