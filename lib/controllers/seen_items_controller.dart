import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/seen_item.dart';

class SeenItemsController {
  /// ключ для сохранённого значения
  static const _storageKey = 'seen_items';

  /// хранилище данных
  late final Box<SeenItem> _storage;

  /// слушатель изменений в хранилище
  ValueListenable<Box<SeenItem>> get listenable => _storage.listenable();

  SeenItemsController() {
    /// регистрируем модель для просмотренных эпизодов
    Hive.registerAdapter(SeenItemAdapter());
    Hive.registerAdapter(SeenEpisodeAdapter());

    /// инициализируем хранилище
    Hive.openBox<SeenItem>(_storageKey).then((box) => _storage = box);
    
  }

  /// обновляем информацию о времени просмотра эпизода
  void updatePosition({
    required String tag,
    required dynamic parentId,
    required dynamic episodeId,
    required String name,
    required int position,
    required int duration,
    required bool subtitlesEnabled,
    required String episodeName,
  }) {

    final key = SeenItem.getKey(
      tag: tag,
      id: parentId.toString(),
    );

    /// ищем запись просмотра сериала или фильма в БД
    SeenItem? seenItem = _storage.get(key);

    if (seenItem == null) {
      /// ^ если запись не найдена в БД

      /// создаём новую запись
      seenItem = SeenItem(
        tag: tag,
        id: parentId.toString(),
        name: name,
        updatedAt: DateTime.now(),
        subtitlesEnabled: subtitlesEnabled,
        episodes: {},
      );

      /// сохраняем новую запись
      _storage.put(key, seenItem);

    } else {
      /// ^ если запись уже существует в БД
      
      /// обновляем состояние субтитров
      seenItem.subtitlesEnabled = subtitlesEnabled;

      /// обновляем дату просмотра
      seenItem.updatedAt = DateTime.now();
    }

    if (seenItem.episodes.containsKey(episodeId.toString())) {
      /// ^ если запись уже существует в БД
      final seenEpisode = seenItem.episodes[episodeId.toString()]!;
      
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
