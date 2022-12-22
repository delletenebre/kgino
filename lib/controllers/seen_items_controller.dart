import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/episode_item.dart';
import '../models/movie_item.dart';

class SeenItemsController {
  /// ключ для сохранённого значения
  static const storageKey = 'seen_items';

  /// хранилище данных
  late final Box<MovieItem> _storage;

  /// слушатель изменений в хранилище
  ValueListenable<Box<MovieItem>> get listenable => _storage.listenable();

  SeenItemsController() {
    _storage = Hive.box<MovieItem>(SeenItemsController.storageKey);
  }

  /// обновляем информацию о времени просмотра эпизода
  void updatePosition({
    required MovieItem movie,
    required EpisodeItem episode,
    required int position,
    required bool subtitlesEnabled,
  }) {

    /// ищем запись просмотра сериала или фильма в БД
    MovieItem? seenItem = _storage.get(movie.storageKey);

    if (seenItem == null) {
      /// ^ если запись не найдена в БД
      
      /// создаём запись в БД
      seenItem = movie;

      /// сохраняем новую запись
      _storage.put(seenItem.storageKey, seenItem);

    }

    /// обновляем состояние субтитров
    seenItem.subtitlesEnabled = subtitlesEnabled;

    /// обновляем дату просмотра
    seenItem.updatedAt = DateTime.now();


    late final EpisodeItem seenEpisode;
    final seenEpisodeIndex = seenItem.episodes.indexOf(episode);

    if (seenEpisodeIndex > -1) {
      /// ^ если эпизод уже существует в БД
      
      seenEpisode = seenItem.episodes[seenEpisodeIndex];

    } else {
      /// ^ если запись не найдена в БД

      /// создаём новую запись о просмотре эпизода
      seenEpisode = episode;

      /// сохраняем запись
      seenItem.episodes.add(seenEpisode);

    }

    /// обновляем запись
    seenEpisode.position = position;
    seenEpisode.updatedAt = DateTime.now();

    /// сохраняем обновления
    seenItem.save();

  }

  MovieItem? findItemByKey(String key) => _storage.get(key);

  EpisodeItem? findEpisode({
    required String storageKey,
    required String episodeId,
  }) {
    final seenItem = findItemByKey(storageKey);
    if (seenItem != null) {
      return seenItem.episodes.firstWhereOrNull((episode) {
        return episode.id == episodeId;
      });
    }

    return null;
  }

  List<MovieItem> find(MovieItemType type, { int count = 0 }) {
    List<MovieItem> items = _storage.values.where((item) {
      return item.type == type && item.episodes.isNotEmpty;
    }).toList();
    
    /// сортируем по убыванию времени последнего просмотра
    items.sort((a, b) {
      return b.updatedAt.compareTo(a.updatedAt);
    });
    
    if (count > 0) {
      items = items.take(count).toList();
    }
    
    return items;
  }

  /// удаляем из избранного
  List<MovieItem> takeFavoritesOf(MovieItemType type) {
    final favorites = _storage.values.where((item) {
      return item.type == type && item.favorite;
    });
    
    return favorites.sortedBy((element) => element.updatedAt).reversed.toList();
  }

  /// проверяем есть ли элемент в избранном
  bool hasFavorite(MovieItem item) {
    return _storage.get(item.storageKey)?.favorite ?? false;
  }

  /// добавляем в избранное
  void addFavorite(MovieItem item) {
    final savedItem = _storage.get(item.storageKey) ?? item;
    savedItem.favorite = true;

    if (savedItem.box == null) {
      /// сохраняем значение на диск
      _storage.put(savedItem.storageKey, savedItem);
    } else {
      savedItem.save();
    }
  }

  /// удаляем из избранного
  void removeFavorite(MovieItem item) {
    final savedItem = _storage.get(item.storageKey)!;
    savedItem.favorite = false;
    savedItem.save();
  }

}
