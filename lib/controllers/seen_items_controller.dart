import 'package:collection/collection.dart';
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
  }) {

    final key = SeenItem.getKey(
      tag: tag,
      id: parentId,
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
        episodes: {},
      );

      /// сохраняем новую запись
      _storage.put(key, seenItem);

    } else {
      /// ^ если запись уже существует в БД
      
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
        position: position,
        duration: duration,
        updatedAt: DateTime.now(),
      );

      /// сохраняем запись
      seenItem.episodes.putIfAbsent(episodeId.toString(), () => seenEpisode);

    }

    /// сохраняем обновления
    seenItem.save();

  }

  // List<SeenItem> findByParentId({required String tag, String parentId = ''}) {
  //   return _storage.values.where((element) {
  //     return element.tag == tag && element.parentId == parentId;
  //   }).toList();
  // }

  SeenItem? getByKey(String key) => _storage.get(key);

  SeenEpisode? findEpisode({
    required String tag,
    required dynamic itemId,
    required dynamic episodeId,
  }) {
    final seenItem = getByKey(SeenItem.getKey(tag: tag, id: itemId.toString()));
    if (seenItem != null) {
      return seenItem.episodes[episodeId.toString()];
    }

    return null;
  }

  List<SeenItem> findByTag(String tag) {
    return _storage.values.where((item) => item.tag == tag).toList();
  }

  // /// удаляем сериал из избранного
  // void remove(String showId) {
  //   box.delete(showId);
  // }

}
