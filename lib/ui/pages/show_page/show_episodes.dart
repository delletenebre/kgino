import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_episode.dart';

class ShowEpisodes extends StatelessWidget {
  final List<TskgEpisode> episodes;

  const ShowEpisodes(this.episodes, { Key? key }) : super(key: key);

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
              value: 0.8,
              color: theme.colorScheme.primary.withOpacity(0.2),
              backgroundColor: Colors.transparent,
            ),

            Material(
              color: Colors.transparent,
              child: ListTile(
                leading: SizedBox(
                  width: 40.0,
                  child: Center(
                    child: Text(episode.quality),
                  ),
                ),
                title: Text(episode.title),
                subtitle: episode.description.isEmpty
                  ? null
                  : Text(episode.description),
                onTap: () {

                },
              ),
            )
          ],
        );
      }).toList(),
    );
  }
}