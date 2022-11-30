import 'package:hive_flutter/hive_flutter.dart';

import '../../models/tskg/tskg_favorite.dart';
import '../../models/tskg/tskg_show.dart';

class TskgFavoritesController {
  /// ключ для сохранённого значения
  static const boxName = 'tskg_favorites';

  /// хранилище данных
  final box = Hive.box<TskgFavorite>(boxName);

  TskgFavoritesController();

  /// добавляем сериал в избранное
  void add(TskgShow show) {
    final episodeCount = show.seasons.fold(0, (previousValue, season) {
      return previousValue + season.episodes.length;
    });

    final favorite = TskgFavorite(
      showId: show.showId,
      name: show.name,
      episodeCount: episodeCount,
      createdAt: DateTime.now(),
    );
    
    /// сохраняем значение на диск
    box.put(show.showId, favorite);
  }

  /// удаляем сериал из избранного
  void remove(String showId) {
    box.delete(showId);
  }

  List<TskgFavorite> get sorted {
    final favorites = box.values.toList()
      ..sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });

    return favorites;
  }

}
