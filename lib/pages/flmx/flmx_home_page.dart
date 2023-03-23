import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../../api/flmx_api_provider.dart';
import '../../models/kgino_item.dart';
import '../../ui/app_header.dart';
import '../../ui/krs_item_details.dart';
import '../../ui/lists/horizontal_list_view.dart';
import '../../ui/lists/movie_list_tile.dart';
import '../../ui/lists/vertical_list_view.dart';

class FlmxHomePage extends HookWidget {
  const FlmxHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final api = GetIt.instance<FlmxApiProvider>();

    /// список последний добавлений
    final asyncLatest = useMemoized(() => api.getCatalog());

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppHeader(
            child: Text('Filmix'),
          ),

          KrsItemDetails(
            kginoItem: KginoItem(
              id: '',
              name: 'ansd a ndnasdnas d',
              provider: KginoProvider.flmx,
              type: KginoItemType.movie,
              posterUrl: '',
              updatedAt: DateTime.now(),

            ),
          ),

          Expanded(
            child: VerticalListView(
              itemCount: 2,
              itemBuilder: (context, focusNode, index) {
                return HorizontalListView<KginoItem>(
                  focusNode: focusNode,
                  titleText: 'Новые',
                  itemsFuture: Future.microtask(() async {
                    final response = await asyncLatest;

                    if (response.isSuccess) {
                      return response.asData.data;
                    }

                    return [];
                  }),
                  itemBuilder: (context, focusNode, index, item) {
                    return MovieListTile(
                      focusNode: focusNode,
                      onFocused: (focusNode) {
                        
                      },
                      onTap: () {
                        
                      },
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