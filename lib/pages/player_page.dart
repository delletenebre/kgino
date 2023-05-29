import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/episode_item.dart';
import '../models/kgino_item.dart';
import '../ui/video_player/video_player_view.dart';

class PlayerPage extends HookWidget {
  final KginoItem kginoItem;
  final String episodeId;
  final bool saveProgress;

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
    this.saveProgress = true,
  });


  @override
  Widget build(BuildContext context) {
    /// все эпизоды в одном списке
    final episodes = useMemoized(() {
      return kginoItem.getAllEpisodes();
    });

    /// текущий индекс в плейлисте
    final currentIndex = useState(episodes.indexWhere((episode) {
      return episode.id == episodeId;
    }));

    return VideoPlayerView(
      titleText: kginoItem.name,
      subtitlesEnabled: kginoItem.subtitlesEnabled,
      onInitialPlayableItem: () => getPlayableItem(
        true,
        episodes[currentIndex.value],
        kginoItem.storageKey,
      ),

      onSkipNext: (currentIndex.value + 1 < episodes.length) ? () {
        /// переходим к следующему файлу
        currentIndex.value++;

        return getPlayableItem(
          false,
          episodes[currentIndex.value],
          kginoItem.storageKey,
        );
      } : null,

      onSkipPrevious: (currentIndex.value > 0) ? () {
        /// переходим к предыдущему файлу
        currentIndex.value--;

        return getPlayableItem(
          false,
          episodes[currentIndex.value],
          kginoItem.storageKey,
        );
      } : null,

      onUpdatePosition: (episode, subtitlesEnabled) {
        if (saveProgress) {
          kginoItem.subtitlesEnabled = subtitlesEnabled;

          kginoItem.save();
          if (kginoItem.seenEpisodes.lookup(episode) != null) {
            kginoItem.seenEpisodes.remove(episode);
          }
          kginoItem.seenEpisodes.add(episode);
          kginoItem.save();
        }
      },

      onQualityChanged: (quality) async {
        kginoItem.playableQuality = quality;
        await kginoItem.save();

        return getPlayableItem(
          true,
          episodes[currentIndex.value],
          kginoItem.storageKey,
        );
      },
    );
  }
}
