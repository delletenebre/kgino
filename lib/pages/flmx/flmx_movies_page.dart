import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../../api/flmx_api_provider.dart';
import '../../models/category_list_item.dart';
import '../../models/kgino_item.dart';
import '../../ui/app_header.dart';
import '../../ui/krs_item_details.dart';
import '../../ui/lists/horizontal_list_view.dart';
import '../../ui/lists/kgino_list_tile.dart';
import '../../ui/lists/vertical_list_view.dart';

class FlmxMoviesPage extends HookWidget {
  const FlmxMoviesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final api = GetIt.instance<FlmxApiProvider>();
    
    /// последние добавления
    final asyncLatest = useMemoized(() => api.getLatestMovies());

    /// популярные фильмы
    final asyncPopular = useMemoized(() => api.getPopularMovies());

    final categories = [

      CategoryListItem(
        title: 'Новые',
        apiResponse: asyncLatest,
      ),

      CategoryListItem(
        title: 'Популярное',
        apiResponse: asyncPopular,
      ),

    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppHeader(
            child: Text('Filmix'),
          ),

          KrsItemDetails(
            kginoItem: KginoItem(
              provider: KginoProvider.flmx.name,
              id: '',
              name: 'ansd a ndnasdnas d',
              posterUrl: '',
            ),
          ),

          Expanded(
            child: VerticalListView(
              itemCount: categories.length,
              itemBuilder: (context, focusNode, index) {
                final category = categories[index];

                return HorizontalListView<KginoItem>(
                  focusNode: focusNode,
                  titleText: category.title,
                  itemsFuture: category.itemsFuture,
                  itemBuilder: (context, focusNode, index, item) {
                    return KginoListTile(
                      focusNode: focusNode,
                      onFocused: (focusNode) {
                        
                      },
                      onTap: () {
                        
                      },
                      item: item,
                    );
                  },
                  
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}