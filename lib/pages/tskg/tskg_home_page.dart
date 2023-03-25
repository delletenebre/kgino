import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../../api/tskg_api_provider.dart';
import '../../models/category_list_item.dart';
import '../../models/kgino_item.dart';
import '../../ui/app_header.dart';
import '../../ui/krs_item_details.dart';
import '../../ui/lists/horizontal_list_view.dart';
import '../../ui/lists/kgino_list_tile.dart';
import '../../ui/lists/vertical_list_view.dart';

class TskgHomePage extends HookWidget {
  const TskgHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final api = GetIt.instance<TskgApiProvider>();
    
    /// последние добавления
    final asyncLatest = useMemoized(() => api.getLatestShows());

    /// популярные
    final asyncPopular = useMemoized(() => api.getPopularShows());

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
            child: Text('TS.KG'),
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