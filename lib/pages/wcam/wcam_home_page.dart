import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

          if (elcatState.isLoading || ktState.isLoading) {
            return const LoadingIndicator();
          }

          final categories = <CategoryListItem<MovieItem>>[];

          if (saimaState.isSuccess) {
            categories.add(
              CategoryListItem(
                title: 'Saima Telecom',
                items: saimaState.data,
              )
            );
          }

          if (elcatState.isSuccess) {
            categories.add(
              CategoryListItem(
                title: 'ЭлКат',
                items: elcatState.data,
              )
            );
          }

          if (ktState.isSuccess) {
            categories.add(
              CategoryListItem(
                title: 'Кыргызтелеком',
                items: ktState.data,
              )
            );
          }

          if (citylinkState.isSuccess) {
            categories.add(
              CategoryListItem(
                title: 'Ситилинк',
                items: citylinkState.data,
              )
            );
          }

          categories.add(
            CategoryListItem(
              title: 'Интересное',
              items: [
                MovieItem.webcamera(
                  name: 'Кенийский водопой',
                  posterUrl: '',
                  videoFileUrl: 'https://www.youtube.com/watch?v=6NIt6ibAD6I',
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
                    child: KrsHorizontalListView(
                      focusNode: focusNode,
                      onItemFocused: (index) {
                        // context.read<WcamController>().getShowById(
                        //   category.items[index].id,
                        // );
                      },
                      onLoadNextPage: category.title.startsWith('Ситилинк') ? () {
                        context.read<CitylinkCamerasController>().fetchCameras();
                      } : null,
                      titleText: category.title,
                      itemCount: category.items.length,
                      itemBuilder: (context, focusNode, index) {
                        final item = category.items.elementAt(index);
                        
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