// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// import '../../api/ockg_api_provider.dart';
// import '../../models/ockg/ockg_movie.dart';

// export '../../models/request_state.dart';

// class OckgCatalogController extends Cubit<List<OckgMovie>> {

//   final _api = GetIt.instance<OckgApiProvider>();

//   final _pagingController = PagingController<int, OckgMovie>(
//     firstPageKey: 1,
//   );

//   PagingController<int, OckgMovie> get pagingController => _pagingController;

//   int _offset = 0;
//   int _pageSize = 20;

//   final int genreId;

//   OckgCatalogController({
//     this.genreId = 0,
//   }) : super([]) {
//     _pagingController.addPageRequestListener((pageKey) {
//       fetchPage(pageKey);
//     });
//   }

//   @override
//   Future<void> close() {
//     _pagingController.dispose();
//     return super.close();
//   }

//   Future<void> fetchPage(int pageKey) async {
//     try {
//       final newPage = await _api.getCatalog(
//         genreId: genreId,
//         offset: pageKey * _pageSize,
//       );

//       final previouslyFetchedItemsCount =
//           _pagingController.itemList?.length ?? 0;

//       final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
//       final newItems = newPage.movies;

//       if (isLastPage) {
//         _pagingController.appendLastPage(newItems);
//       } else {
//         final nextPageKey = pageKey + 1;
//         _pagingController.appendPage(newItems, nextPageKey);
//       }
//     } catch (error) {
//       _pagingController.error = error;
//     }
//   }
  

//   // void changeLocale(String locale) {
    
//   // }

//   // @override
//   // Future<void> onChange(Change<RequestState<List<OckgBestsellersCategory>>> change) async {
//   //   super.onChange(change);

//   // }
// }
