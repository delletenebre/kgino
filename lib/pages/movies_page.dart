import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/kgino_raw_list_tile.dart';
import '../ui/lists/vertical_list_view.dart';

class MoviesPage extends HookWidget {
  const MoviesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return VerticalListView(
      itemCount: 1,
      itemBuilder: (context, focusNode, index) {
        return HorizontalListView(
          focusNode: focusNode,
          titleText: 'Выберите сервис',
          itemsFuture: Future.delayed(Duration.zero, () {
            return [
              /// ссылка на filmix
              {
                'name': 'Filmix',
                // 'imageUrl': 'https://filmix.ac/templates/Filmix/media/img/svg/logo.svg',
                'imageUrl': 'assets/images/flmx.svg',
                'route': '/flmx/movies',
              },

              /// ссылка на oc.kg
              {
                'name': 'OC.KG',
                'imageUrl': 'https://oc.kg/templates/mobile/img/logooc_winter.png',
                // 'imageUrl': 'assets/images/ockg.svg',
                'route': '/ockg',
              },

            ];
          }),
          itemBuilder: (context, focusNode, index, item) {
            return KginoRawListTile(
              focusNode: focusNode,
              onFocused: (focusNode) {
                
              },
              onTap: () {
                context.push(item['route']!);
              },
              title: item['name']!,
              imageUrl: item['imageUrl']!,
            );
          },
          
        );
      },
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Container(
    //       padding: const EdgeInsets.symmetric(
    //         horizontal: 24.0,
    //       ),
    //       height: KrsTheme.movieDetailsHeight,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           Text('Yfpasdasdkaj  asdajsdnlasdm mlasmdkamskdl askmd ',
    //             style: TextStyle(
    //               fontSize: 18.0,
    //             ),
    //           ),

    //           Row(
    //             children: [
    //               Chip(
    //                 padding: const EdgeInsets.all(0.0),
    //                 label: Text('2022'),
    //               )
    //             ],
    //           ),

    //           Text('Эвелин получает доступ к воспоминаниям, эмоциям и невероятным способностям других версии? себя. Теперь она может прожить тысячи жизней и быть кем угодно - известной актрисой, мастером боевых искусств, оперной дивой и даже небесным божеством. Но всем мультивселенным угрожает таинственная сущность, с которой Эвелин предстоит сразиться. Как знать, возможно, заодно она разберётся и с самым страшным злом - своими налогами.'),

    //         ],
    //       ),
    //     ),

    //     Expanded(
    //       child: VerticalListView(
    //         itemCount: 2,
    //         itemBuilder: (context, focusNode, index) {
    //           return HorizontalListView(
    //             focusNode: focusNode,
    //             titleText: 'Gjcktlrbs',
    //             itemsFuture: Future.delayed(Duration(seconds: 1), () {
    //               return [100, 200, 5, 7, 8, 10,100, 200, 5, 7, 8, 10,100, 200, 5, 7, 8, 10,100, 200, 5, 7, 8, 10];
    //             }),
    //             itemBuilder: (context, focusNode, index, item) {
    //               return MovieListTile(
    //                 focusNode: focusNode,
    //                 onFocused: (focusNode) {
                      
    //                 },
    //                 onTap: () {
                      
    //                 },
    //               );
    //             },
                
    //           );
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}