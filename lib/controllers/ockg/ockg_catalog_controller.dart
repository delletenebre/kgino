import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/ockg_api_provider.dart';
import '../../models/ockg/ockg_catalog.dart';

export '../../models/request_state.dart';

class OckgCatalogController extends Cubit<OckgCatalog> {

  final _api = GetIt.instance<OckgApiProvider>();

  OckgCatalog _currentCatalog = const OckgCatalog();

  static const _pageSize = 20;

  final int genreId;

  OckgCatalogController({
    this.genreId = 0,
  }) : super(const OckgCatalog()) {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final catalog = await _api.getCatalog(
        genreId: genreId,
        offset: _currentCatalog.offset + _pageSize,
      );

      if (catalog.movies.isNotEmpty) {
        _currentCatalog = catalog.copyWith(
          movies: [ ..._currentCatalog.movies, ...catalog.movies ],
        );
        emit(_currentCatalog);
      }

    } catch (exception) {
      debugPrint('OckgCatalogController fetchMovies() exception: $exception');
    }
  }

}
