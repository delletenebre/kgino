import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/ui/pages/tskg_slider.dart';
import 'package:kgino/ui/sliders/slider_card.dart';
import 'package:kgino/ui/sliders/slider_title.dart';

class FavoriteSlider extends GetView<FavoritesController> {
  const FavoriteSlider({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (controller.items.isEmpty) {
      /// ^ если список избранного пуст
    
      return const SizedBox();
    
    } else {
      /// ^ если в списке избранного есть элементы

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SliderTitle('Избранные'),

          Obx(() => TskgSlider(
            items: controller.items.values.map((show) {
              return SliderCard(
                posterUrl: TskgApi.getPosterUrl(show.showId),
                title: show.title,
                // badges: tskgItem.badges,
                onTap: () {
                  /// при нажатии на сериал
                  
                  /// переходим на страницу информации о сериале
                  Get.toNamed('/tskg/show/${show.showId}');
                },
              );
            }).toList(),
          )),

        ],
      );
    }
  }
}