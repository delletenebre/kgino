import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/ockg_api_provider.dart';
import '../../models/ockg/ockg_movie.dart';

export '../../models/request_state.dart';

class OckgCatalogController extends Cubit<List<OckgMovie>> {

  final _api = GetIt.instance<OckgApiProvider>();

  final _currentMovieList = <OckgMovie>[];

  int _offset = 0;
  static const _pageSize = 20;

  final int genreId;

  OckgCatalogController({
    this.genreId = 0,
  }) : super([]) {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final catalog = await _api.getCatalog(
        genreId: genreId,
        offset: _offset + _pageSize,
      );

      if (catalog.movies.isNotEmpty) {
        _offset = catalog.offset;
        _currentMovieList.addAll(catalog.movies);
        emit(_currentMovieList);
      }

      // final previouslyFetchedItemsCount =
      //     _pagingController.itemList?.length ?? 0;

      // final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      // final newItems = newPage.movies;

      // if (isLastPage) {
      //   _pagingController.appendLastPage(newItems);
      // } else {
      //   final nextPageKey = pageKey + 1;
      //   _pagingController.appendPage(newItems, nextPageKey);
      // }
    } catch (error) {
      //_pagingController.error = error;
    }
  }

  // void changeLocale(String locale) {
    
  // }

  // @override
  // Future<void> onChange(Change<RequestState<List<OckgBestsellersCategory>>> change) async {
  //   super.onChange(change);

  // }
}
