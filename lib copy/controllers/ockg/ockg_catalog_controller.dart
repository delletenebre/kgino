import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kgino/models/ockg/ockg_movie.dart';

import '../../api/ockg_api_provider.dart';
import '../../models/ockg/ockg_catalog.dart';

export '../../models/request_state.dart';

enum OckgCatalogType {
  genre,
  selection,
}

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
  final String id;

  final OckgCatalogType type;

  OckgCatalogController({
    this.id = '',
    required this.type,
  }) : super(const OckgCatalog()) {
    //fetchMovies();
  }

  Future<void> fetchMovies() async {
    if (_currentCatalog.movies.length < _currentCatalog.total
      || _currentCatalog.movies.isEmpty) {
      /// ^ если фильмов в текущем каталоге меньше чем должно быть
      /// или фильмы ещё не загружены
      try {

        /// запрашиваем данные каталога
        late final OckgCatalog catalog;

        switch (type) {
          
          case OckgCatalogType.genre:
            catalog = await _api.getCatalog(
              genreId: id,
              offset: _currentCatalog.offset + (_currentPage * _pageSize),
              pageSize: _pageSize,
            );
            break;

          case OckgCatalogType.selection:
            catalog = await _api.getCatalog(
              selectionId: id,
              offset: _currentCatalog.offset + (_currentPage * _pageSize),
              pageSize: _pageSize,
            );
            break;
        }

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

  Future<List<OckgMovie>> getMovies(int page, int loadedItemsLength) async {
    try {

      /// запрашиваем данные каталога
      late final OckgCatalog catalog;

      switch (type) {
        
        case OckgCatalogType.genre:
          catalog = await _api.getCatalog(
            genreId: id,
            offset: loadedItemsLength + (page * _pageSize),
            pageSize: _pageSize,
          );
          break;

        case OckgCatalogType.selection:
          catalog = await _api.getCatalog(
            selectionId: id,
            offset: loadedItemsLength + (page * _pageSize),
            pageSize: _pageSize,
          );
          break;
      }

      if (!isClosed) {
        /// ^ если контроллер ещё существует

        return catalog.movies;
      }

    } catch (exception) {
      debugPrint('OckgCatalogController getMovies() exception: $exception');
    }

    return [];
  }

  static final Map<String, String> genres = {
    '4': 'Комедии',
    '13': 'Мультфильмы',
    '6': 'Боевики',
    '34': 'Фантастика',
    '35': 'Триллеры',
    '7': 'Ужасы',
    '32': 'Детективы',
    '17': 'Мелодрамы',
    '12': 'Приключения',
    '37': 'Фэнтези',
    '2': 'Драмы',
    '36': 'Семейные',
    '20': 'Биографии',
    '25': 'Аниме',
    '23': 'Документальные',
    '21': 'Короткомеражки',
  }; 

  // int getGenreId() {
  //   switch (name) {
  //     case 'Боевики':
  //       return 6;
  //     case 'Триллер':
  //       return 34;
  //     case 'Комедии':
  //       return 4;
  //     case 'Драма/мелодрама':
  //       return 2;
  //     case 'Сериалы':
  //       return 33;
  //     case 'Мультфильмы':
  //       return 13;
  //     case 'Ужасы':
  //       return 7;
  //     case 'Документальные':
  //       return 23;
  //     case 'Аниме':
  //       return 25;
  //     case 'Детектив':
  //       return 32;
  //     default:
  //       return 1;
  //   }
  // }

}
