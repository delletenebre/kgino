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
      /// ^ если был передан идентификатор фильма
      
      /// запрашиваем данные о фильме
      getMovieById(movieId);
    } else {
      _api.getPopMovies().then((movies) {
        if (movies.isNotEmpty) {
          getMovieById(movies.first.movieId);
        }
      });
    }
  }

  Future<void> getMovieById(int movieId) async {
    /// запроашиваем данные о фильме
    final movie = await _api.getMovie(movieId);
    
    if (movie == null) {
      /// ^ если данных нет
      emit(const RequestState.empty());
    
    } else {
      /// ^ если запрос выполнен успешно
      
      emit(RequestState.success(movie));
    }
  }


  Future<void> getMovie(OckgMovie movie) async {
    if (movie.createdAt == null) {
      /// ^ если данные о фильме не полные
      
      /// запроашиваем данные о фильме
      getMovieById(movie.movieId);

    } else {
      /// ^ если данные о фильме уже есть
      
      emit(RequestState.success(movie));
    
    }

  }

}
