import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_episode.dart';
import 'package:kgino/utils/utils.dart';

class ShowEpisodes extends StatelessWidget {
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

    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      primary: false,
      children: episodes.map((episode) {
        return Stack(
          children: [
            LinearProgressIndicator(
              minHeight: episode.description.isEmpty ? 56.0 : 72.0,
              value: 0.0, // TODO fix add episode progress
              color: theme.colorScheme.primary.withOpacity(0.2),
              backgroundColor: Colors.transparent,
            ),

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