import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import '../models/kgino_item.dart';
import '../models/category_list_item.dart';
import '../resources/krs_storage.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/kgino_list_tile.dart';
import '../ui/lists/kgino_raw_list_tile.dart';
import '../ui/lists/vertical_list_view.dart';

class ShowsPage extends HookWidget {
  const ShowsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    /// хранилище данных
    final storage = GetIt.instance<KrsStorage>();

    final categories = useState({

      '0': CategoryListItem(
        title: 'Выберите сервис',
        items: [
          KginoItem(
            provider: KginoProvider.flmxShow.name,
            id: '/flmx/shows',
            name: 'Filmix',
            posterUrl: 'assets/images/flmx.svg',
            isFolder: true,
          ),

          KginoItem(
            provider: KginoProvider.tskg.name,
            id: '/tskg',
            name: 'TS.KG',
            posterUrl: 'assets/images/tskg.svg',
            isFolder: true,
          ),
        ],
      ),

    });

    /// фильтруем сохранённые сериалы
    final savedItemsQuery = storage.db.kginoItems
      .where()
      .filter()
      .bookmarkedIsNotNull()
      .providerEqualTo(KginoProvider.flmxShow.name)
      .or()
      .providerEqualTo(KginoProvider.tskg.name)
      .sortByBookmarkedDesc()
      .build();

    final savedItems = savedItemsQuery.watch(fireImmediately: true);
    savedItems.listen((data) {
      final a = {...categories.value};
      a['1'] = CategoryListItem(
        title: 'В закладках',
        items: data,
      );
      categories.value = a;
    });

    return VerticalListView(
      itemCount: categories.value.length,
      itemBuilder: (context, focusNode, index) {
        final category = categories.value.values.elementAt(index);

        return HorizontalListView<KginoItem>(
          focusNode: focusNode,
          titleText: category.title,
          itemsFuture: category.itemsFuture,
          itemBuilder: (context, focusNode, index, item) {

            if (item.isFolder) {
              return KginoRawListTile(
                focusNode: focusNode,
                onFocused: (focusNode) {
                  
                },
                onTap: () {
                  context.push(item.id);
                },
                title: item.name,
                imageUrl: item.posterUrl,
              );
            }

            /// карточка фильма
            return KginoListTile(
              focusNode: focusNode,
              onTap: () {
                /// переходим на страницу фильма
                context.pushNamed('flmxMovieDetails',
                  pathParameters: {
                    'id': item.id,
                  },
                );
              },
              item: item,
            );

          },
          
        );
      },
    );

    // return VerticalListView(
    //   itemCount: 1,
    //   itemBuilder: (context, focusNode, index) {
    //     return HorizontalListView(
    //       focusNode: focusNode,
    //       titleText: 'Выберите сервис',
    //       itemsFuture: Future.delayed(Duration.zero, () {
    //         return [
    //           /// ссылка на filmix
    //           {
    //             'name': 'Filmix',
    //             // 'imageUrl': 'https://filmix.ac/templates/Filmix/media/img/svg/logo.svg',
    //             'imageUrl': 'assets/images/flmx.svg',
    //             'route': '/flmx/shows',
    //           },

    //           /// ссылка на ts.kg
    //           {
    //             'name': 'TS.KG',
    //             // 'imageUrl': 'https://www.ts.kg/img/logo.svg',
    //             'imageUrl': 'assets/images/tskg.svg',
    //             'route': '/tskg',
    //           },

    //         ];
    //       }),
    //       itemBuilder: (context, focusNode, index, item) {
    //         return KginoRawListTile(
    //           focusNode: focusNode,
    //           onFocused: (focusNode) {
                
    //           },
    //           onTap: () {
    //             context.push(item['route']!);
    //           },
    //           title: item['name']!,
    //           imageUrl: item['imageUrl']!,
    //         );
    //       },
          
    //     );
    //   },
    // );
  }
}