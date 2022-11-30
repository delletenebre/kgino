import 'package:hive_flutter/hive_flutter.dart';

import '../models/seen_episode.dart';

class SeenEpisodesController {
  /// ключ для сохранённого значения
  static const boxName = 'seen_episodes';

  /// хранилище данных
  final box = Hive.box<SeenEpisode>(boxName);

  SeenEpisodesController();

  // /// добавляем сериал в избранное
  // void add(TskgEpisode episode) {

  //   final favorite = TskgFavorite(
  //     showId: show.showId,
  //     name: show.name,
  //     episodeCount: episodeCount,
  //     createdAt: DateTime.now(),
  //   );
    
  //   /// сохраняем значение на диск
  //   box.put(show.showId, favorite);
  // }

  // /// удаляем сериал из избранного
  // void remove(String showId) {
  //   box.delete(showId);
  // }

}
