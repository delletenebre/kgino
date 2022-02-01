import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kgino/api/tskg/models/tskg_item.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/ui/pages/app_page.dart';
import 'package:kgino/ui/pages/home_page/favorites_slider.dart';
import 'package:kgino/ui/pages/tskg_slider.dart';
import 'package:kgino/ui/sliders/slider_card.dart';
import 'package:kgino/ui/sliders/slider_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppPage(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// список избранного
          const FavoriteSlider(),

          const SliderTitle('Последние поступления'),

          FutureBuilder<List<TskgItem>>(
            future: TskgApi.getNews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                
                /// список слайдеров с элементами последних поступлений,
                /// сгруппированные по дате добавления
                final children = <Widget>[];

                /// для группировки по атрибуту [TskgItem.date] элементы
                /// необходимо сконвертировать в [Map]
                final tskgItemsJson = snapshot.data?.map((item) {
                  return item.toJson();
                }) ?? {};

                /// элементы сгруппированные по дате добавления
                final itemsGroupedByDate = groupBy(
                  tskgItemsJson,
                  (Map item) => item['date']
                );

                /// за какое количество дней нужно отобразить элементы
                const numberOfDays = 2;

                final maxIndex = (itemsGroupedByDate.length < numberOfDays)
                  ? itemsGroupedByDate.length
                  : numberOfDays;

                /// счётчик для анимации [Hero]
                // var itemsIndex = 0;

                for (int i = 0; i < maxIndex; i++) {
                  /// дата добавления сериала
                  final dateString = itemsGroupedByDate.keys.elementAt(i);
                  final date = DateTime.parse(dateString);

                  final dateFormatter = DateFormat('dd MMM');

                  /// список сериалов за определённый день
                  final elements = itemsGroupedByDate.values.elementAt(i);
                  final items = elements.map((itemJson) {

                    /// конвертируем [Map] обратно в [TskgItem]
                    final tskgItem = TskgItem.fromJson(itemJson);

                    /// идентификатор для анимации [Hero]
                    // final heroTag = tskgItem.tvshowId + itemsIndex.toString();
                    // itemsIndex++;

                    /// формируем карточку сериала
                    return SliderCard(
                      posterUrl: TskgApi.getPosterUrl(tskgItem.showId),
                      title: tskgItem.title,
                      description: tskgItem.subtitle,
                      badges: tskgItem.badges,
                      onTap: () {
                        /// при нажатии на сериал
                        
                        /// переходим на страницу информации о сериале
                        Get.toNamed('/tskg/show/${tskgItem.showId}');
                      },
                    );

                  });

                  /// добавляем слайдер с последними поступлениями за
                  /// определённый день
                  children.add(
                    TskgSlider(
                      title: dateFormatter.format(date),
                      items: items.toList(),
                    )
                  );
                }
                
                /// добавляем слайдеры с последними поступлениями
                return Column(
                  children: children,
                );
              }

              /// пока идёт запрос данных - показываем индикатор загрузки
              return const SizedBox(
                height: 160.0 / 5 * 4,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}