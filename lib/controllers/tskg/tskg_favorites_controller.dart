import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/tskg/tskg_favorite.dart';
import '../../models/tskg/tskg_show.dart';

class TskgFavoritesController {
  /// ключ для сохранённого значения
  static const _storageKey = 'tskg_favorites';

  /// хранилище данных
  Box<TskgFavorite>? _storage;

  /// слушатель изменений в хранилище
  ValueListenable<Box<TskgFavorite>>? get listenable => _storage!.listenable();

  TskgFavoritesController() {
    /// регистрируем модель для избранных сериалов 
    Hive.registerAdapter(TskgFavoriteAdapter());
    
    /// инициализируем хранилище
    Hive.openBox<TskgFavorite>(_storageKey).then((box) => _storage = box);
  }

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
    _storage?.put(show.showId, favorite);
  }

  /// удаляем сериал из избранного
  void remove(String showId) {
    _storage?.delete(showId);
  }

  List<TskgFavorite> get sorted {
    final favorites = _storage!.values.toList()
      ..sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });

    return favorites;
  }

}
