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
      final seenEpisode = episode;

      /// сохраняем запись
      seenItem.episodes.add(seenEpisode);

    }

    /// обновляем запись
    seenEpisode.position = position;
    seenEpisode.updatedAt = DateTime.now();
    
    seenEpisode.save();

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

  List<MovieItem> findByType(MovieItemType type) {
    final items = _storage.values.where((item) => item.type == type).toList()
      ..sort((a, b) {
        return b.updatedAt.compareTo(a.updatedAt);
      });
    
    return items;
  }

}
