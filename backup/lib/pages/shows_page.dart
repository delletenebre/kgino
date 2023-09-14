import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import '../models/category_list_item.dart';
import '../models/kgino_item.dart';
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

    /// фильтруем сохранённые сериалы
    final savedItemsQuery = storage.db.kginoItems
      .where()
      .filter()
      .not()
      .bookmarkedIsNull()
      //.bookmarkedIsNotNull()
      .and()
      .group((q) => q
        .providerEqualTo(KginoProvider.tskg.name)
        .or()
        .providerEqualTo(KginoProvider.flmxShow.name)
      )
      .sortByBookmarkedDesc()
      .build();

    final stream = useMemoized(() => savedItemsQuery.watch(fireImmediately: true));
    final savedItems = useStream(stream);

    final categories = [
      CategoryListItem(
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

      CategoryListItem(
        title: 'В закладках',
        items: savedItems.data ?? [],
      ),

    ];

    return VerticalListView(
      itemCount: categories.length,
      itemBuilder: (context, focusNode, index) {
        final category = categories.elementAt(index);

        return HorizontalListView<KginoItem>(
          key: ObjectKey(category),
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
                /// переходим на страницу сериала
                context.pushNamed(item.provider == KginoProvider.flmxShow.name
                  ? 'flmxShowDetails' : 'tskgDetails',
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

  }
}