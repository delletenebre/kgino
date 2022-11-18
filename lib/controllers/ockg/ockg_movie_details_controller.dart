import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/ockg_api_provider.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../models/request_state.dart';

export '../../models/request_state.dart';

class OckgMovieDetailsController extends Cubit<RequestState<OckgMovie>> {

  final _api = GetIt.instance<OckgApiProvider>();

  OckgMovieDetailsController() : super(const RequestState.loading()) {
    
  }


  Future<void> getMovie(OckgMovie movie) async {
    if (movie.createdAt == null) {
      /// ^ если данные о фильме не полные
      
      /// запроашиваем данные о фильме
      final response = await _api.getMovie(movie.movieId);
      
      if (response == null) {
        /// ^ если данных нет
        emit(const RequestState.empty());
      } else {
        /// ^ если запрос выполнен успешно
        
        /// обновляем данные о фильме
        movie = response;
      }
    }
    
    emit(RequestState.success(movie));
  }
}
