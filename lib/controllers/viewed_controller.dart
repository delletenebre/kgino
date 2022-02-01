import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kgino/models/viewed_episode_model.dart';
import 'package:kgino/models/viewed_show_model.dart';

class ViewedController extends GetxController  {
  /// хранилище данных
  static const storageName = 'viewed';

  /// список просмотренных сериалов
  final _items = Hive.box<ViewedShowModel>(storageName).obs;

  Box<ViewedShowModel> get items => _items.value;

  void updateEpisode(String showId, int episodeId, int position) {
    final updatedAt = DateTime.now();
    
    final show = items.get(showId) ?? ViewedShowModel(showId, []);
    final episode = show.episodes.firstWhereOrNull((episode) {
      return episode.id == episodeId;
    }) ?? ViewedEpisodeModel(episodeId, position, updatedAt);

    episode.position = position;
    episode.updatedAt = updatedAt;

    show.episodes..remove(episode)..add(episode);

    _items.value.put(showId, show);
    _items.refresh();
  }

  int getEpisodeProgress({required String showId, required int episodeId}) {
    if (items.containsKey(showId)) {

      final show = items.get(showId)!;
      final episode = show.episodes.firstWhereOrNull((episode) {
        return episode.id == episodeId;
      });

      if (episode != null) {
        return episode.position;
      }

    }

    return 0;
  }
}