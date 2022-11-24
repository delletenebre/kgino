import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/ockg_api_provider.dart';
import '../../models/ockg/ockg_catalog.dart';

export '../../models/request_state.dart';

class OckgCatalogController extends Cubit<OckgCatalog> {

  /// провайдер запросов к API
  final _api = GetIt.instance<OckgApiProvider>();

  /// каталог с фильмами и информацией об общем количестве фильмов
  OckgCatalog _currentCatalog = const OckgCatalog();

  /// количество элементов на странице
  static const _pageSize = 15;

  /// текущая страница
  int _currentPage = 0;

  /// идентификатор жанра
  final int genreId;

  OckgCatalogController({
    this.genreId = 0,
  }) : super(const OckgCatalog()) {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    if (_currentCatalog.movies.length < _currentCatalog.total
      || _currentCatalog.movies.isEmpty) {
      /// ^ если фильмов в текущем каталоге меньше чем должно быть
      /// или фильмы ещё не загружены
      try {

        /// запрашиваем данные каталога
        final catalog = await _api.getCatalog(
          genreId: genreId,
          offset: _currentCatalog.offset + (_currentPage * _pageSize),
          pageSize: _pageSize,
        );

        if (!isClosed) {
          /// ^ если контроллер ещё существует

          if (catalog.movies.isNotEmpty) {
            /// ^ если данные о фильмах получены успешно
            
            /// обновляем каталог
            _currentCatalog = catalog.copyWith(
              movies: [ ..._currentCatalog.movies, ...catalog.movies ],
            );
            _currentPage++;
            emit(_currentCatalog);
          }
          
        }

      } catch (exception) {
        debugPrint('OckgCatalogController fetchMovies() exception: $exception');
      }
    }
  }

}
