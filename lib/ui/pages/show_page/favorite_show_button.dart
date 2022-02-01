import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_show.dart';
import 'package:kgino/controllers/controllers.dart';

class FavoriteShowButton extends GetView<FavoritesController> {
  final TskgShow show;
  
  const FavoriteShowButton({
    Key? key,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      if (controller.isShowInFavorite(show.id)) {
        /// ^ если сериал уже в списке избранного

        return OutlinedButton.icon(
          onPressed: () {
            controller.removeShowFromFavorites(show.id);
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
            controller.addShowToFavorites(show);
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
    });
  }
}