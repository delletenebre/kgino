import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/ockg_api_provider.dart';
import '../../models/ockg/ockg_movie.dart';

export '../../models/request_state.dart';

class OckgCatalogController extends Cubit<List<OckgMovie>> {

  final _api = GetIt.instance<OckgApiProvider>();
  final _currentMovieList = <OckgMovie>[];

  int _offset = 0;

  final int genreId;

  OckgCatalogController({
    this.genreId = 0,
  }) : super([]) {
    _api.getCatalog(
      genreId: genreId,
      offset: _offset,
    ).then((movies) {
      if (movies.isNotEmpty) {
        _currentMovieList.addAll(movies);
        /// ^ если данные получены успешно
        emit(_currentMovieList);
      }
    });
  }

  // void changeLocale(String locale) {
    
  // }

  // @override
  // Future<void> onChange(Change<RequestState<List<OckgBestsellersCategory>>> change) async {
  //   super.onChange(change);

  // }
}
