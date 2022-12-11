import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../../controllers/tskg/tskg_show_details_controller.dart';
import '../../controllers/wcam/elcat_cameras_controller.dart';
import '../../controllers/wcam/kt_cameras_controller.dart';
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
        BlocProvider<ElcatCamerasController>(
          create: (context) => ElcatCamerasController(),
        ),

        BlocProvider<KtCamerasController>(
          create: (context) => KtCamerasController(),
        ),
      ],
      
      child: Builder(
        builder: (context) {

          final elcatState = context.watch<ElcatCamerasController>().state;
          final ktState = context.watch<KtCamerasController>().state;

          if (elcatState.isLoading || ktState.isLoading) {
            return const LoadingIndicator();
          }

          final categories = <CategoryListItem<MovieItem>>[];

          if (elcatState.isSuccess) {
            categories.add(
              CategoryListItem(
                title: 'Elcat.kg',
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
                      titleText: category.title,
                      itemCount: category.items.length,
                      itemBuilder: (context, focusNode, index) {
                        final item = category.items.elementAt(index);
                        
                        return KrsListItemCard(
                          focusNode: focusNode,
                          item: item,
                          
                          /// при выб оре элемента
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