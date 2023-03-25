import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../../api/flmx_api_provider.dart';
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

    /// список последний добавлений
    final asyncLatest = useMemoized(() => api.getLatestMovies());

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
              itemCount: 1,
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