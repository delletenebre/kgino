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
import '../../resources/krs_locale.dart';
import '../../ui/app_header.dart';
import '../../ui/krs_item_details.dart';
import '../../ui/lists/horizontal_list_view.dart';
import '../../ui/lists/kgino_list_tile.dart';
import '../../ui/lists/vertical_list_view.dart';

class FlmxShowsPage extends HookWidget {
  const FlmxShowsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    /// контроллер расширенной информации о фильме
    final detailsCubit = KginoItemDetailsCubit();

    /// провайдер запросов к API
    final api = GetIt.instance<FlmxApiProvider>();

    /// список последний добавлений
    final asyncLatest = useMemoized(() => api.getLatestShows());

    /// популярные
    final asyncPopular = useMemoized(() => api.getPopularShows());

    final categories = [

      CategoryListItem(
        title: locale.latest,
        apiResponse: asyncLatest,
      ),

      CategoryListItem(
        title: locale.popular,
        apiResponse: asyncPopular,
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
                const AppHeader(
                  child: Text('Filmix / Сериалы'),
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

                      /// категория сериалов (горизонтальный список)
                      return HorizontalListView<KginoItem>(
                        focusNode: focusNode,
                        titleText: category.title,
                        itemsFuture: category.itemsFuture,
                        itemBuilder: (context, focusNode, index, item) {

                          /// карточка сериала
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

                              /// переходим на страницу сериала
                              context.goNamed('flmxShowDetails', params: {
                                'id': item.id,
                              });
                              
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