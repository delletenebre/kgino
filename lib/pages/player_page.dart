import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../../models/episode_item.dart';
import '../models/kgino_item.dart';
import '../resources/krs_storage.dart';
import '../ui/loading_indicator.dart';
import '../ui/video_player/video_player_view.dart';

class PlayerPage extends HookWidget {
  final KginoItem kginoItem;
  final String episodeId;
  final Future<EpisodeItem> Function(
    bool initial,
    EpisodeItem currentEpisode,
    String seenShowStorageKey,
  ) getPlayableItem;

  const PlayerPage({
    super.key,
    required this.kginoItem,
    required this.getPlayableItem,
    this.episodeId = '',
  });


  @override
  Widget build(BuildContext context) {
    /// хранилище данных
    final storage = GetIt.instance<KrsStorage>();

    final dbItemFuture = useFuture(useMemoized(() {
      return storage.db.kginoItems.get(kginoItem.isarId);
    }));

    /// все эпизоды в одном списке
    final episodes = useMemoized(() {
      return kginoItem.getAllEpisodes();
    });

    /// текущий индекс в плейлисте
    final currentIndex = useState(episodes.indexWhere((episode) {
      return episode.id == episodeId;
    }));

    if (dbItemFuture.connectionState != ConnectionState.done) {
      /// если запрос из базы данных ещё не выполнен

      /// показываем индикатор загрузки
      return const LoadingIndicator();
    }

    /// сохранённый в базе данных элемент
    final dbItem = dbItemFuture.data ?? kginoItem;

    return VideoPlayerView(
      titleText: dbItem.name,
      subtitlesEnabled: dbItem.subtitlesEnabled,
      onInitialPlayableItem: () => getPlayableItem(
        true,
        episodes[currentIndex.value],
        dbItem.storageKey,
      ),

      onSkipNext: (currentIndex.value + 1 < episodes.length) ? () {
        /// переходим к следующему файлу
        currentIndex.value++;

        return getPlayableItem(
          false,
          episodes[currentIndex.value],
          dbItem.storageKey,
        );
      } : null,

      onSkipPrevious: (currentIndex.value > 0) ? () {
        /// переходим к предыдущему файлу
        currentIndex.value--;

        return getPlayableItem(
          false,
          episodes[currentIndex.value],
          dbItem.storageKey,
        );
      } : null,

      onUpdatePosition: (episode, position, subtitlesEnabled) {
        // _seenItemsController.updatePosition(
        //   movie: dbItem,
        //   episode: episode,
        //   position: position,
        //   subtitlesEnabled: subtitlesEnabled,
        // );
      }
    );
  }
}
