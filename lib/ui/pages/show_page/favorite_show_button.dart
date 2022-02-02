import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_show.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/ui/shadowed_icon.dart';

class FavoriteShowButton extends GetView<FavoritesController> {
  final TskgShow show;
  
  const FavoriteShowButton({
    Key? key,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (controller.isShowInFavorite(show.id)) {
        /// ^ если сериал уже в списке избранного

        return OutlinedButton.icon(
          onPressed: () {
            controller.removeShowFromFavorites(show.id);
          },
          icon: const ShadowedIcon(Icons.favorite_border),
          label: const Text('Убрать из избранного'),
        );
      
      } else {
          /// ^ если сериала нет в списке избранного

        return OutlinedButton.icon(
          onPressed: () {
            controller.addShowToFavorites(show);
          },
          icon: const ShadowedIcon(Icons.favorite),
          label: const Text('Добавить в избранное'),
        );
      
      }
    });
    
  }
}