import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../api/wcam_api_provider.dart';
import '../models/category_list_item.dart';
import '../models/kgino_item.dart';
import '../resources/krs_locale.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/kgino_list_tile.dart';
import '../ui/lists/vertical_list_view.dart';

class CamerasPage extends HookWidget {
  const CamerasPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    /// провайдер запросов к API
    final api = GetIt.instance<WcamApiProvider>();

    final asyncElcat = useMemoized(() {
      return api.getElcatCameras();
    });

    final categories = [

      CategoryListItem(
        title: 'Элкат',
        apiResponse: asyncElcat,
      ),

      CategoryListItem(
        title: 'Интересное',
        items: [

          KginoItem.webcamera(
            name: 'Кенийский водопой',
            posterUrl: 'https://i.ytimg.com/vi/KyQAB-TKOVA/hqdefault_live.jpg',
            videoFileUrl: 'https://www.youtube.com/watch?v=KyQAB-TKOVA',
          ),

          KginoItem.webcamera(
            name: 'Африканские животные',
            posterUrl: 'https://i.ytimg.com/vi/O8xVFhgEv6Q/hqdefault_live.jpg',
            videoFileUrl: 'https://www.youtube.com/watch?v=O8xVFhgEv6Q',
          ),

          KginoItem.webcamera(
            name: 'Сафари камера',
            posterUrl: 'https://i.ytimg.com/vi/QkWGGhtTA4k/hqdefault_live.jpg',
            videoFileUrl: 'https://www.youtube.com/watch?v=QkWGGhtTA4k',
          ),

          KginoItem.webcamera(
            name: 'Парк слонов',
            posterUrl: 'https://i.ytimg.com/vi/VUJbDTIYlM4/hqdefault_live.jpg',
            videoFileUrl: 'https://www.youtube.com/watch?v=VUJbDTIYlM4',
          ),

          KginoItem.webcamera(
            name: 'Таймс-сквер, Нью-Йорк',
            posterUrl: 'https://i.ytimg.com/vi/1-iS7LArMPA/hqdefault_live.jpg',
            videoFileUrl: 'https://www.youtube.com/watch?v=1-iS7LArMPA',
          ),
          
        ],
      )

      // CategoryListItem(
      //   title: 'TS.KG',
      //   apiResponse: asyncTskgSearchResults,
      // ),

      // CategoryListItem(
      //   title: 'Online Cinema',
      //   apiResponse: asyncOckgSearchResults,
      // ),

    ];

    return Scaffold(
      body: Builder(
        builder: (context) {
          return VerticalListView(
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
                    onTap: () {
                      /// переходим на страницу плеера камеры
                      context.pushNamed('wcamPlayer',
                        queryParameters: {
                          'episodeId': item.seasons.first.episodes.first.id,
                        },
                        extra: item,
                      );
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