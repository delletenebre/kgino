import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kgino/api/tskg/models/tskg_show.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/ui/pages/player_page/player_error.dart';
import 'package:kgino/ui/pages/show_page/show_seasons.dart';
import 'package:kgino/ui/pages/show_page/view_show_button.dart';

class ShowDetails extends StatelessWidget {

  /// идентификатор сериала
  final String showId;
  
  const ShowDetails(this.showId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const delimiterHeight = 12.0;

    /// контроллер избранного
    final favoritesController = Get.find<FavoritesController>();

    /// контроллер просмотренных эпизодов
    final viewedController = Get.find<ViewedController>();

    return FutureBuilder<TskgShow>(
      
      /// запрашиваем данные о сериале
      future: TskgApi.getShow(showId),

      builder: (context, snapshot) {
        late Widget content;

        if (snapshot.hasData) {
          /// ^ если загрузка данных завершена

          final show = snapshot.data;

          if (show != null && show.id.isNotEmpty) {
            /// ^ если данные по сериалу получены успешно
            
            /// изображение страны производителя
            final countryImages = show.countries.map<Widget>((country) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.network(country.imageUrl,
                  height: 18.0,
                  placeholderBuilder: (context) => Text(country.name),
                ),
              );
            }).toList();


            /// название сериала на языке оригинала
            Widget originalTitle = const SizedBox();
            if (show.originalTitle.isNotEmpty) {
              /// ^ если есть название сериала на языке оригинала
              
              originalTitle = Padding(
                padding: const EdgeInsets.only(bottom: delimiterHeight),
                child: Text(show.originalTitle,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: theme.textTheme.caption?.color,
                    shadows: [
                      Shadow(
                        color: theme.scaffoldBackgroundColor,
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                ),
              );
            }
          
            content = Container(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [

                    /// невидимый элемент для фокуса в начало страницы
                    const Focus(
                      child: SizedBox(
                        width: double.maxFinite,
                        height: kToolbarHeight,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// название сериала
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: delimiterHeight
                            ),
                            child: Text(show.title,
                              style: TextStyle(
                                fontSize: 32.0,
                                shadows: [
                                  Shadow(
                                    color: theme.scaffoldBackgroundColor,
                                    blurRadius: 2.0,
                                  ),
                                  Shadow(
                                    color: theme.scaffoldBackgroundColor,
                                    blurRadius: 4.0,
                                  ),
                                  Shadow(
                                    color: theme.scaffoldBackgroundColor,
                                    blurRadius: 6.0,
                                  ),
                                  Shadow(
                                    color: theme.scaffoldBackgroundColor,
                                    blurRadius: 8.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// название сериала на языке оригинала
                          originalTitle,

                          /// флаг страны и года показа
                          Row(
                            children: countryImages..add(
                              Text(show.years,
                                style: TextStyle(
                                  color: theme.textTheme.caption?.color,
                                  shadows: [
                                    Shadow(
                                      color: theme.scaffoldBackgroundColor,
                                      blurRadius: 4.0,
                                    ),
                                  ],
                                ),)
                            ),
                          ),

                          const SizedBox(height: delimiterHeight),

                          /// описание сериала
                          Text(show.description,
                            style: TextStyle(
                              color: theme.textTheme.caption?.color,
                              shadows: [
                                Shadow(
                                  color: theme.scaffoldBackgroundColor,
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: delimiterHeight * 2),

                          /// кнопка смотреть/продолжить просмотр
                          ViewShowButton(
                            showId: showId,
                          ),

                          /// кнопка добавить/удалить из избранного
                          Obx(() {
                            if (favoritesController.isShowInFavorite(showId)) {
                              /// ^ если сериал уже в списке избранного

                              return OutlinedButton.icon(
                                onPressed: () {
                                  favoritesController.removeShowFromFavorites(showId);
                                },
                                icon: Icon(Icons.favorite_border,
                                  color: theme.colorScheme.primary,
                                ),
                                label: const Text('Убрать из избранного'),
                              );
                            
                            } else {
                               /// ^ если сериала нет в списке избранного

                              return OutlinedButton.icon(
                                onPressed: () {
                                  favoritesController.addShowToFavorites(show);
                                },
                                icon: DecoratedIcon(Icons.favorite,
                                  color: theme.colorScheme.primary,
                                  shadows: [
                                    BoxShadow(
                                      blurRadius: 12.0,
                                      color: theme.scaffoldBackgroundColor,
                                    ),
                                  ],
                                ),
                                label: const Text('Добавить в избранное'),
                              );
                            
                            }
                          }),
                          
                          OutlinedButton.icon(
                            onPressed: () {

                            },
                            icon: Icon(Icons.shuffle,
                              color: theme.colorScheme.primary,
                            ),
                            label: const Text('Просмотр в случайном порядке'),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: delimiterHeight * 2),

                    /// эпизоды сериала, сгруппированные по сезонам
                    ShowSeasons(
                      seasons: show.seasons,
                      onEpisodeTap: (episode) {
                        Get.toNamed('/tskg/show/$showId/play/${episode.id}');
                      }
                    ),

                    /// невидимый элемент для фокуса в конце страницы
                    const Focus(
                      child: SizedBox(
                        width: double.maxFinite,
                      ),
                    ),

                  ],
                ),
              ),
            );
          
          } else {
            /// ^ если есть какая-то ошибка в данных по сериалу
            
            content = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayerError(
                  message: 'При загрузке данных произошла ошибка',
                  onRetry: () {

                  }
                ),
              ],
            );
          }

        } else {
          /// ^ если загрузка данных не завершена

          /// показываем индикатор загрузки
          content = const Center(
            child: CircularProgressIndicator(),
          );

        }


        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: content,
        );
      }
    );
  }
}