import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/ockg_api_provider.dart';
import '../../models/movie_item.dart';
import '../../models/request_state.dart';

export '../../models/request_state.dart';

class OckgMovieDetailsController extends Cubit<RequestState<OckgMovieItem>> {

  /// идентификатор фильма
  final String movieId;

  /// провайдер запросов к API
  final _api = GetIt.instance<OckgApiProvider>();

  OckgMovieDetailsController({
    this.movieId = '',
  }) : super(const RequestState.loading()) {
    if (movieId.isNotEmpty) {
      getMovieById(movieId);
    }
  }

  Future<void> getMovieById(String movieId, { bool showPlayButton = false }) async {
    if (state.isSuccess && state.data.id == movieId) {
      /// ^ если запрашиваемый фильм уже загружен
      
      /// ничего не делать
      return;
    }

    if (!isClosed) {
      emit(const RequestState.loading());
      
      /// запроашиваем данные о фильме
      final movie = await _api.getMovie(movieId);

      if (!isClosed) {
        /// ^ если контроллер ещё существует
        
        if (movie == null) {
          /// ^ если данных нет
          
          emit(const RequestState.empty());
        
        } else {
          /// ^ если запрос выполнен успешно
          
          emit(RequestState.success(movie));
        
        }
      }
    }
  }


  // Future<void> showPopularMovies() async {
  //   // запрашиваем список популярных фильмов
  //   final movies = await _api.getPopMovies();
    
  //   if (movies.isNotEmpty) {
  //     // ^ если данные получены успешно

  //     // запрашиваем информацию по первому фильму
  //     getMovieById(movies.first.id, showPlayButton: true);
  //   }
  // }

}
