import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/ockg_api_provider.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../models/request_state.dart';

export '../../models/request_state.dart';

class OckgMovieDetailsController extends Cubit<RequestState<OckgMovie>> {

  final int movieId;

  final _api = GetIt.instance<OckgApiProvider>();

  OckgMovieDetailsController({
    this.movieId = 0,
  }) : super(const RequestState.loading()) {
    if (movieId > 0) {
      getMovieById(movieId);
    }
  }

  Future<void> getMovieById(int movieId, { bool showPlayButton = false }) async {
    /// запроашиваем данные о фильме
    final movie = await _api.getMovie(movieId);

    if (movie == null) {
      /// ^ если данных нет
      emit(const RequestState.empty());
    
    } else {
      /// ^ если запрос выполнен успешно
      emit(RequestState.success(movie.copyWith(showPlayButton: showPlayButton)));
    
    }
  }


  Future<void> showPopularMovies() async {
    // запрашиваем список популярных фильмов
    final movies = await _api.getPopMovies();
    
    if (movies.isNotEmpty) {
      // ^ если данные получены успешно

      // запрашиваем информацию по первому фильму
      getMovieById(movies.first.movieId, showPlayButton: true);
    }
  }

}
