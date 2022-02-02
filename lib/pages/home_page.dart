import 'package:flutter/material.dart';
import 'package:kgino/ui/pages/app_page.dart';
import 'package:kgino/ui/pages/home_page/favorite_shows_slider.dart';
import 'package:kgino/ui/pages/home_page/last_added_shows_slider.dart';
import 'package:kgino/ui/pages/home_page/last_viewed_shows_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppPage(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [

          /// список избранного
          FavoriteShowsSlider(),

          /// список последних поступлений
          LastAddedShowsSlider(),

          /// список последних просмотров
          LastViewedShowsSlider(),
        ],
      ),
    );
  }
}