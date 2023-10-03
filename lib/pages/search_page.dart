import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/filmix_api_provider.dart';
import '../api/tskg_api_provider.dart';
import '../models/category_list_item.dart';
import '../models/media_item.dart';
import '../providers/providers.dart';
import '../resources/constants.dart';
import '../ui/cards/media_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    // провайдер запросов к API
    final filmixApi = ref.read(filmixApiProvider);

    // провайдер запросов к API
    final tskgApi = ref.read(tskgApiProvider);

    /// контроллер поискового запроса
    final searchController = ref.read(searchProvider);
    useValueListenable(searchController);

    final asyncFilmixSearchResults = useMemoized(() {
      return filmixApi.search(
        searchQuery: searchController.text,
        cancelToken: filmixApi.getCancelToken(),
      );
    }, [searchController.text]);

    final asyncTskgSearchResults = useMemoized(() {
      return tskgApi.search(
        searchQuery: searchController.text,
        cancelToken: tskgApi.getCancelToken(),
      );
    }, [searchController.text]);

    final categories = [
      CategoryListItem(
        title: 'Filmix',
        apiResponse: asyncFilmixSearchResults,
      ),
      CategoryListItem(
        title: 'TS.KG',
        apiResponse: asyncTskgSearchResults,
      ),
    ];

    return VerticalListView(
      key: ValueKey(searchController.text),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: TvUi.vPadding),
          child: HorizontalListView<MediaItem>(
            key: UniqueKey(),
            itemHeight: TvUi.horizontalCardSize.height,
            title: Text(category.title),
            asyncItems: category.itemsFuture,
            itemBuilder: (context, index, item) {
              return MediaCard(
                onTap: () {
                  /// переходим на страницу деталей о сериале
                  context.goNamed('details', extra: item);
                },
                title: item.title,
                imageUrl: item.poster,
              );
            },
          ),
        );
      },
    );
  }
}
