import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../api/wcam_api_provider.dart';
import '../../constants.dart';
import '../../models/category_list_item.dart';
import '../../models/movie_item.dart';
import '../../ui/lists/krs_horizontal_list_view.dart';
import '../../ui/lists/krs_list_item_card.dart';
import '../../ui/lists/krs_vertical_list_view.dart';

class WcamHomePage extends HookWidget {
  const WcamHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final api = GetIt.instance<WcamApiProvider>();

    /// список новых сериалов
    final asyncSaimaItems = useMemoized(() => api.getSaimaCameras());

    /// список новых сериалов
    final asyncElcatItems = useMemoized(() => api.getElcatCameras());

    /// список новых сериалов
    final asyncKtItems = useMemoized(() => api.getKtCameras());

    final categories = <CategoryListItem<MovieItem>>[];

    categories.add(
      CategoryListItem(
        title: 'Saima Telecom',
        itemsFuture: asyncSaimaItems,
      )
    );

    categories.add(
      CategoryListItem(
        title: 'ЭлКат',
        itemsFuture: asyncElcatItems,
      )
    );

    categories.add(
      CategoryListItem(
        title: 'Кыргызтелеком',
        itemsFuture: asyncKtItems,
      )
    );

    // categories.add(
    //   CategoryListItem(
    //     title: 'Ситилинк',
    //     items: citylinkState.data,
    //   )
    // );

    categories.add(
      CategoryListItem(
        title: 'Интересное',
        items: [

          MovieItem.webcamera(
            name: 'Кенийский водопой',
            posterUrl: 'https://i.ytimg.com/vi/KyQAB-TKOVA/hqdefault_live.jpg',
            videoFileUrl: 'https://www.youtube.com/watch?v=KyQAB-TKOVA',
          ),

          MovieItem.webcamera(
            name: 'Африканские животные',
            posterUrl: 'https://i.ytimg.com/vi/O8xVFhgEv6Q/hqdefault_live.jpg',
            videoFileUrl: 'https://www.youtube.com/watch?v=O8xVFhgEv6Q',
          ),

          MovieItem.webcamera(
            name: 'Сафари камера',
            posterUrl: 'https://i.ytimg.com/vi/QkWGGhtTA4k/hqdefault_live.jpg',
            videoFileUrl: 'https://www.youtube.com/watch?v=QkWGGhtTA4k',
          ),

          MovieItem.webcamera(
            name: 'Парк слонов',
            posterUrl: 'https://i.ytimg.com/vi/VUJbDTIYlM4/hqdefault_live.jpg',
            videoFileUrl: 'https://www.youtube.com/watch?v=VUJbDTIYlM4',
          ),

          MovieItem.webcamera(
            name: 'Таймс-сквер, Нью-Йорк',
            posterUrl: 'https://i.ytimg.com/vi/1-iS7LArMPA/hqdefault_live.jpg',
            videoFileUrl: 'https://www.youtube.com/watch?v=1-iS7LArMPA',
          ),
          
        ],
      )
    );
    
    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: KrsVerticalListView(
        itemCount: categories.length,
        itemBuilder: (context, focusNode, index) {
          final category = categories[index];

          return KrsHorizontalListView<MovieItem>(
            focusNode: focusNode,
            height: tskgListViewHeight + 16.0,
            onLoadNextPage: category.title.startsWith('Ситилинк') ? (page, loadedCount) {
              final api = GetIt.instance<WcamApiProvider>();
              return  api.getCitylinkCameras(
                city: '',
                page: page,
              );
            } : null,
            items: category.items,
            itemsFuture: category.itemsFuture,
            titleText: category.title,
            itemBuilder: (context, focusNode, index, item) {
              return KrsListItemCard(
                focusNode: focusNode,
                item: item,
                
                /// при выборе элемента
                onTap: () {
                  /// переходим на страницу деталей о сериале
                  context.goNamed('wcamPlayer',
                    extra: item.seasons.first.episodes.first,
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