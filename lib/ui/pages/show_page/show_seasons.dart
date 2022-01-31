import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_episode.dart';
import 'package:kgino/api/tskg/models/tskg_season.dart';
import 'package:kgino/ui/pages/show_page/show_episodes.dart';

class ShowSeasons extends StatelessWidget {
  final List<TskgSeason> seasons;
  final Function(TskgEpisode) onEpisodeTap;

  const ShowSeasons({
    Key? key,
    this.seasons = const [],
    required this.onEpisodeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _seasons = <Widget>[];
    for (final season in seasons) {
      _seasons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(season.title,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
        )
      );
      _seasons.add(const SizedBox(height: 12.0));
      _seasons.add(
        ShowEpisodes(
          episodes: season.episodes,
          onTap: (episode) {
            /// при нажатии на эпизод
            onEpisodeTap.call(episode);
          }
        )
      );
      _seasons.add(const SizedBox(height: 44.0));
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _seasons,
    );
  }
}