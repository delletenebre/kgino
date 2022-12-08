import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/tskg_api_provider.dart';
import '../../models/movie_item.dart';
import '../../models/request_state.dart';

export '../../models/request_state.dart';

class TskgShowDetailsController extends Cubit<RequestState<TskgMovieItem>> {

  /// идентификатор сериала
  final String showId;

  /// провайдер запросов к API
  final _api = GetIt.instance<TskgApiProvider>();

  TskgShowDetailsController({
    this.showId = '',
  }) : super(const RequestState.loading()) {
    if (showId.isNotEmpty) {
      getShowById(showId);
    }
  }

  Future<void> getShowById(String showId, { bool showPlayButton = false }) async {
    if (state.isSuccess && state.data.id == showId) {
      /// ^ если запрашиваемый сериал уже загружен
      
      /// ничего не делать
      return;
    }

    emit(const RequestState.loading());
    
    /// запроашиваем данные о сериале
    final show = await _api.getShow(showId);

    if (!isClosed) {
      /// ^ если контроллер ещё существует
      if (show.id.isEmpty) {
        /// ^ если данных нет
        
        emit(const RequestState.empty());
      
      } else {
        /// ^ если запрос выполнен успешно
        
        emit(RequestState.success(show));
      
      }
    }
  }


  // Future<void> showPopularMovies() async {
  //   // запрашиваем список популярных фильмов
  //   final movies = await _api.getPopMovies();
    
  //   if (movies.isNotEmpty) {
  //     // ^ если данные получены успешно

  //     // запрашиваем информацию по первому фильму
  //     getMovieById(movies.first.showId, showPlayButton: true);
  //   }
  // }

}
