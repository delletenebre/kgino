import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../api/flmx_api_provider.dart';
import '../api/ockg_api_provider.dart';
import '../api/tskg_api_provider.dart';
import '../models/category_list_item.dart';
import '../models/kgino_item.dart';
import '../resources/krs_locale.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/kgino_list_tile.dart';
import '../ui/lists/vertical_list_view.dart';

// Key seachResultsKey = ValueKey('');

class SearchPage extends HookWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    /// контроллер расширенной информации о фильме
    // final detailsCubit = KginoItemDetailsCubit();

    /// провайдер запросов к API
    final flmxApi = GetIt.instance<FlmxApiProvider>();

    /// провайдер запросов к API
    final tskgApi = GetIt.instance<TskgApiProvider>();

    /// провайдер запросов к API
    final ockgApi = GetIt.instance<OckgApiProvider>();

    // final updateSeachResultsKey = useState(UniqueKey());

    

    /// контроллер поискового запроса
    final searchController = GetIt.instance<TextEditingController>();
    final searchQuery = searchController.text;

    useValueListenable(searchController);
    
    final asyncTskgSearchResults = useMemoized(() {
      return tskgApi.searchShows(searchQuery);
    }, [searchController.text]);

    final asyncFlmxSearchResults = useMemoized(() {
      return flmxApi.searchMovies(searchQuery);
    }, [searchController.text]);

    final asyncOckgSearchResults = useMemoized(() {
      return ockgApi.searchMovies(searchQuery);
    }, [searchController.text]);

    final categories = [

      CategoryListItem(
        title: 'Filmix',
        apiResponse: asyncFlmxSearchResults,
      ),

      CategoryListItem(
        title: 'TS.KG',
        apiResponse: asyncTskgSearchResults,
      ),

      CategoryListItem(
        title: 'Online Cinema',
        apiResponse: asyncOckgSearchResults,
      ),

    ];

    return Scaffold(
      body: Builder(
        builder: (context) {
          return VerticalListView(
            key: ValueKey(searchController.text),
            itemCount: categories.length,
            itemBuilder: (context, focusNode, index) {
              final category = categories[index];

              /// категория сериалов (горизонтальный список)
              return HorizontalListView<KginoItem>(
                focusNode: focusNode,
                titleText: category.title,
                itemsFuture: category.itemsFuture,
                itemBuilder: (context, focusNode, index, item) {

                  /// карточка сериала
                  return KginoListTile(
                    focusNode: focusNode,
                    onFocused: (focusNode) {
                      // final detailsCubit = context.read<KginoItemDetailsCubit>();
                      // /// обновляем идентификатор контроля выполнения запросов
                      // detailsCubit.updateCancelToken();

                      // detailsCubit.fetch(
                      //   api.getMovieDetails(item.id,
                      //     cancelToken: detailsCubit.cancelToken,
                      //   ),
                      // );
                    },
                    onTap: () {

                      /// переходим на страницу детальной информации
                      item.goToDetails(context);
                      
                    },
                    item: item,
                  );

                },
                
              );
            },
          );
        },
      ),
    );
  }
}