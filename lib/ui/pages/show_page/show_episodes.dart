import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_episode.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/utils/utils.dart';

class ShowEpisodes extends GetView<ViewedController> {
  final List<TskgEpisode> episodes;
  final Function(TskgEpisode) onTap;

  const ShowEpisodes({
    Key? key,
    this.episodes = const [],
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// контроллер просмотренных эпизодов
    //final viewedController = Get.find<ViewedController>();

    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      primary: false,
      children: episodes.map((episode) {
        return Stack(
          children: [

            Obx(() {
              /// сколько просмотрено в секундах
              final position = controller.getEpisodeProgress(
                showId: episode.showId,
                episodeId: episode.id
              );

              /// прогресс просмотра в процентах в интервале [0, 1]
              final progress = position / episode.duration.inSeconds;
              
              return LinearProgressIndicator(
                minHeight: episode.description.isEmpty ? 56.0 : 72.0,
                value: progress,
                color: theme.colorScheme.primary.withOpacity(0.2),
                backgroundColor: Colors.transparent,
              );
            }),

            Material(
              color: Colors.transparent,
              child: ListTile(
                /// качесиво записи
                leading: SizedBox(
                  width: 40.0,
                  child: Center(
                    child: Text(episode.quality),
                  ),
                ),

                /// название эпизода
                title: Text(episode.title,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),

                /// описание эпизода (например, перевод)
                subtitle: episode.description.isEmpty
                  ? null
                  : Text(episode.description,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),

                /// продолжительность эпизода
                trailing: SizedBox(
                  width: 100.0,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(Utils.formatDuration(episode.duration)),
                  ),
                ),

                onTap: () {
                  onTap.call(episode);
                },
              ),
            )
          ],
        );
      }).toList(),
    );
  }
}