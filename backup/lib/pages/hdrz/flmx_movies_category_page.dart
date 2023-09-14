import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../api/flmx_api_provider.dart';
import '../../controllers/kgino_item_details_cubit.dart';
import '../../models/api_response.dart';
import '../../models/category_list_item.dart';
import '../../models/kgino_item.dart';
import '../../ui/app_header.dart';
import '../../ui/kgino_item/krs_item_details.dart';
import '../../ui/lists/horizontal_list_view.dart';
import '../../ui/lists/kgino_list_tile.dart';
import '../../ui/lists/vertical_list_view.dart';

class FlmxMoviesCategoryPage extends HookWidget {
  final String categoryId;
  final String categoryName;

  const FlmxMoviesCategoryPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    /// провайдер запросов к API
    final api = GetIt.instance<FlmxApi>();

    /// контроллер расширенной информации о фильме
    final detailsCubit = KginoItemDetailsCubit();

    /// список фильмов в категории
    final asyncMovies = useMemoized(() => api.getMoviesByCategory(categoryId));

    final categories = [
      CategoryListItem(
        title: categoryName,
        apiResponse: asyncMovies,
      ),
    ];

    return Scaffold(
      body: BlocProvider<KginoItemDetailsCubit>(
        create: (context) => detailsCubit,
        child: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// заголовок
                AppHeader(
                  child: Text('Filmix / Фильмы / $categoryName'),
                ),

                /// детали фильма или сериала
                BlocBuilder<KginoItemDetailsCubit, ApiResponse<KginoItem>>(
                  builder: (context, state) {
                    return KrsItemDetails(state);
                  },
                ),

                Expanded(
                  /// общий вертикальный список
                  child: VerticalListView(
                    itemCount: categories.length,
                    itemBuilder: (context, focusNode, index) {
                      final category = categories[index];

                      /// категория фильмов (горизонтальный список)
                      return HorizontalListView<KginoItem>(
                        focusNode: focusNode,
                        titleText: category.title,
                        onLoadNextPage: (page, loadedCount) async {
                          final result = await api.getMoviesByCategory(
                            categoryId,
                            page: page,
                          );
                          if (result.isSuccess) {
                            return result.asData.data;
                          }

                          return [];
                        },
                        itemsFuture: category.itemsFuture,
                        itemBuilder: (context, focusNode, index, item) {
                          /// карточка фильма
                          return KginoListTile(
                            focusNode: focusNode,
                            onFocused: (focusNode) {
                              final detailsCubit =
                                  context.read<KginoItemDetailsCubit>();

                              /// обновляем идентификатор контроля выполнения запросов
                              detailsCubit.updateCancelToken();
                              detailsCubit.fetch(
                                api.getMovieDetails(
                                  item.id,
                                  cancelToken: detailsCubit.cancelToken,
                                ),
                              );
                            },
                            onTap: () {
                              /// переходим на страницу фильма
                              context.pushNamed(
                                'flmxMovieDetails',
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
