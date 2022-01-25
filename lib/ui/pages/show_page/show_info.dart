import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_show.dart';
import 'package:kgino/api/tskg/tskg_api.dart';

class ShowInfo extends StatelessWidget {
  final String showId;
  
  const ShowInfo(this.showId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget dynWidget = const Center(
      child: CircularProgressIndicator(),
    );

    return FutureBuilder<TskgShow>(
      /// запрашиваем данные о сериале
      future: TskgApi.getShow(showId),


      builder: (context, snapshot) {
        

        if (snapshot.hasData) {
          final show = snapshot.data;

          if (show != null && show.id.isNotEmpty) {
            /// ^ если данные по сериалу получены успешно
          
            dynWidget = Container(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    /// невидимый элемент для возврата фокуса в начало страницы
                    const Focus(
                      child: SizedBox(
                        width: double.maxFinite,
                        height: kToolbarHeight,
                      ),
                    ),

                    /// название сериала
                    Text(show.title,
                      style: const TextStyle(
                        fontSize: 32.0,
                      )
                    ),

                    /// название сериала на языке оригинала
                    Text(show.originalTitle,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: theme.textTheme.bodyText2?.color?.withOpacity(0.62),
                      ),
                    ),

                    /// флаг страны и года показа
                    

                  ],
                ),
              ),
            );
          
          } else {
            /// ^ если есть какая-то ошибка в данных по сериалу
            
            dynWidget = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// невидимый элемент для возврата фокуса в начало страницы
                const Focus(
                  child: SizedBox(width: double.maxFinite),
                ),

                Text('Ошибка загрузки данных',

                )
              ],
            );
          }
        }

        /// пока данные не получены, показываем индикатор загрузки
        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: dynWidget,
        );
      }
    );
  }
}