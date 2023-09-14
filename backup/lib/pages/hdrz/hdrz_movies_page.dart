import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../api/hdrz_api_provider.dart';
import '../../controllers/kgino_item_details_cubit.dart';
import '../../models/api_response.dart';
import '../../models/category_list_item.dart';
import '../../models/kgino_item.dart';
import '../../resources/krs_locale.dart';
import '../../ui/app_header.dart';
import '../../ui/kgino_item/krs_item_details.dart';
import '../../ui/lists/horizontal_list_view.dart';
import '../../ui/lists/kgino_list_tile.dart';
import '../../ui/lists/vertical_list_view.dart';

class HdrzMoviesPage extends HookWidget {
  const HdrzMoviesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    /// провайдер запросов к API
    final api = GetIt.instance<HdrzApiProvider>();

    /// контроллер расширенной информации о фильме
    final detailsCubit = KginoItemDetailsCubit();
    
    /// последние добавления
    final asyncLatest = useMemoized(() => api.getLatestMovies());

    // /// популярные
    // final asyncPopular = useMemoized(() => api.getPopularMovies());

    // /// список категорий
    // final asyncCategories = useMemoized(() => api.getCategories());

    final categories = [

      CategoryListItem(
        title: locale.latest,
        apiResponse: asyncLatest,
      ),

      // CategoryListItem(
      //   title: locale.popular,
      //   apiResponse: asyncPopular,
      // ),

      // CategoryListItem(
      //   title: locale.genres,
      //   apiResponse: asyncCategories,
      // ),

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
                const AppHeader(
                  child: Text('HDRezka / Фильмы'),
                ),

                /// детали фильма или сериала
                BlocBuilder<KginoItemDetailsCubit, ApiResponse<KginoItem>>(
                  builder: (context, item) {
                    return KrsItemDetails(item);
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
                        itemsFuture: category.itemsFuture,
                        itemBuilder: (context, focusNode, index, item) {

                          /// карточка фильма
                          return KginoListTile(
                            focusNode: focusNode,
                            onFocused: (focusNode) {
                              final detailsCubit = context.read<KginoItemDetailsCubit>();
                              /// обновляем идентификатор контроля выполнения запросов
                              detailsCubit.updateCancelToken();
                              detailsCubit.fetch(
                                api.getMovieDetails(item.id,
                                  cancelToken: detailsCubit.cancelToken,
                                ),
                              );
                            },
                            onTap: () {
                              
                              if (item.isFolder) {
                                /// ^ если это категория (жанр)
                                
                                /// переходим в папку выбранной категории
                                context.pushNamed('hdrzMoviesCategory',
                                  queryParameters: {
                                    'id': item.id,
                                    'name': item.name,
                                  },
                                );
                              
                              } else {
                                /// ^ если это фильм
                                
                                /// переходим на страницу фильма
                                context.pushNamed('hdrzMovieDetails',
                                  pathParameters: {
                                    'id': item.id,
                                  },
                                );
                              }
                              
                              
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