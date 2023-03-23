import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/kgino_item.dart';
import '../../resources/krs_theme.dart';
import '../../ui/app_header.dart';
import '../../ui/app_logo.dart';
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
                return HorizontalListView(
                  focusNode: focusNode,
                  titleText: 'Gjcktlrbs',
                  itemsFuture: Future.delayed(Duration(seconds: 1), () {
                    return [100, 200, 5, 7, 8, 10,100, 200, 5, 7, 8, 10,100, 200, 5, 7, 8, 10,100, 200, 5, 7, 8, 10];
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