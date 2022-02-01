import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/ui/pages/tskg_slider.dart';
import 'package:kgino/ui/sliders/slider_card.dart';
import 'package:kgino/ui/sliders/slider_title.dart';

class LastViewedShowsSlider extends GetView<ViewedController> {
  
  const LastViewedShowsSlider({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(() {

      if (controller.items.isEmpty) {
        /// ^ если список последних просмотров пуст
      
        return const SizedBox();
      
      } else {
        /// ^ если в списке последних просмотров есть элементы
        
        /// сортируем от новых к старым
        final shows = controller.items.values.toList();
        shows.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        
        /// показываем последние 10 сериалов
        final lastShows = shows.take(10);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SliderTitle('Посление просмотры'),

            TskgSlider(
              items: lastShows.map((show) {
                return SliderCard(
                  posterUrl: TskgApi.getPosterUrl(show.id),
                  title: show.title,
                  onTap: () {
                    /// при нажатии на сериал
                    
                    /// переходим на страницу информации о сериале
                    Get.toNamed('/tskg/show/${show.id}');
                  },
                );
              }).toList(),
            ),

          ],
        );
      }
      
    });
  }
}