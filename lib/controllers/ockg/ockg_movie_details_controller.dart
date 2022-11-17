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
    _api.getMovie(movie.movieId).then((movie) {
      if (movie == null) {
        /// ^ если данных нет
        emit(const RequestState.empty());
      } else {
        /// ^ если данные получены успешно
        emit(RequestState.success(movie));
      }
    });
  }
}
