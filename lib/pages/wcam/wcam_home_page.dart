import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../api/wcam_api_provider.dart';
import '../../constants.dart';
import '../../controllers/wcam/citylink_cameras_controller.dart';
import '../../controllers/wcam/elcat_cameras_controller.dart';
import '../../controllers/wcam/kt_cameras_controller.dart';
import '../../controllers/wcam/saima_cameras_controller.dart';
import '../../models/category_list_item.dart';
import '../../models/movie_item.dart';
import '../../ui/lists/krs_horizontal_list_view.dart';
import '../../ui/lists/krs_list_item_card.dart';
import '../../ui/lists/krs_vertical_list_view.dart';
import '../../ui/loading_indicator.dart';

class WcamHomePage extends StatelessWidget {
  const WcamHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SaimaCamerasController>(
          create: (context) => SaimaCamerasController(),
        ),

        BlocProvider<ElcatCamerasController>(
          create: (context) => ElcatCamerasController(),
        ),

        BlocProvider<KtCamerasController>(
          create: (context) => KtCamerasController(),
        ),

        BlocProvider<CitylinkCamerasController>(
          create: (context) => CitylinkCamerasController(),
        ),

      ],
      
      child: Builder(
        builder: (context) {

          final saimaState = context.watch<SaimaCamerasController>().state;
          final elcatState = context.watch<ElcatCamerasController>().state;
          final ktState = context.watch<KtCamerasController>().state;
          final citylinkState = context.watch<CitylinkCamerasController>().state;

          if (saimaState.isLoading || elcatState.isLoading || ktState.isLoading || citylinkState.isLoading) {
            return const LoadingIndicator();
          }

          final categories = <CategoryListItem<MovieItem>>[];

          categories.add(
            CategoryListItem(
              title: 'Saima Telecom',
              items: saimaState.data,
            )
          );

          categories.add(
            CategoryListItem(
              title: 'ЭлКат',
              items: elcatState.data,
            )
          );

          categories.add(
            CategoryListItem(
              title: 'Кыргызтелеком',
              items: ktState.data,
            )
          );

          categories.add(
            CategoryListItem(
              title: 'Ситилинк',
              items: citylinkState.data,
            )
          );

          categories.add(
            CategoryListItem(
              title: 'Интересное',
              items: [
                MovieItem.webcamera(
                  name: 'Кенийский водопой',
                  posterUrl: 'https://backend.webcamera24.com/static/image/camera/detail/mpala-watering/thumbnail/656x369/hqdefault.webp',
                  videoFileUrl: 'https://www.youtube.com/watch?v=6NIt6ibAD6I',
                ),

                MovieItem.webcamera(
                  name: 'Ниагарский водопад',
                  posterUrl: 'https://backend.webcamera24.com/static/image/camera/detail/niagara-falls/thumbnail/968x545/hqdefault.webp',
                  videoFileUrl: 'https://www.youtube.com/watch?v=kxwuFPFUZyY',
                ),

                MovieItem.webcamera(
                  name: 'Таймс-сквер, Нью-Йорк',
                  posterUrl: 'https://backend.webcamera24.com/static/image/camera/detail/times-square/thumbnail/968x545/hqdefault.webp',
                  videoFileUrl: 'https://www.youtube.com/watch?v=1-iS7LArMPA',
                ),

                
              ],
            )
          );
          


          if (categories.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: KrsVerticalListView(
                itemCount: categories.length,
                itemBuilder: (context, focusNode, index) {
                  final category = categories[index];

                  return SizedBox.fromSize(
                    size: const Size.fromHeight(tskgListViewHeight + 16.0),
                    child: KrsHorizontalListView<MovieItem>(
                      focusNode: focusNode,
                      onLoadNextPage: category.title.startsWith('Ситилинк') ? (page, loadedCount) {
                        final api = GetIt.instance<WcamApiProvider>();
                        return  api.getCitylinkCameras(
                          city: '',
                          page: page,
                        );
                      } : null,
                      items: category.items,
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
                    ),
                  );
                },
                
              ),
            );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }
}