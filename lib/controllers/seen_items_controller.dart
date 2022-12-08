import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/episode_item.dart';
import '../models/movie_item.dart';
import '../models/seen_item.dart';

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


    /// ^ если запись уже существует в БД
    final seenEpisode = seenItem.episodes.indexOf(episode);

    if (seenItem.episodes.containsKey(episode.id)) {
      /// ^ если запись уже существует в БД
      final seenEpisode = seenItem.episodes[episode.id]!;
      
      /// обновляем запись
      seenEpisode.position = position;
      seenEpisode.updatedAt = DateTime.now();

    } else {
      /// ^ если запись не найдена в БД

      /// создаём новую запись о просмотре эпизода
      final seenEpisode = SeenEpisode(
        id: episodeId.toString(),
        position: position,
        duration: duration,
        updatedAt: DateTime.now(),
        name: episodeName,
      );

      /// сохраняем запись
      seenItem.episodes.putIfAbsent(episodeId.toString(), () => seenEpisode);

    }

    /// сохраняем обновления
    seenItem.save();

  }

  SeenItem? findItemByKey(String key) => _storage.get(key);

  SeenEpisode? findEpisode({
    required String tag,
    required dynamic itemId,
    required dynamic episodeId,
  }) {
    final seenItem = findItemByKey(
      SeenItem.getKey(
        tag: tag,
        id: itemId.toString()
      )
    );
    if (seenItem != null) {
      return seenItem.episodes[episodeId.toString()];
    }

    return null;
  }

  List<SeenItem> findByTag(String tag) {
    final items = _storage.values.where((item) => item.tag == tag).toList()
      ..sort((a, b) {
        return b.updatedAt.compareTo(a.updatedAt);
      });
    
    return items;
  }

}
