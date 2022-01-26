import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_season.dart';
import 'package:kgino/ui/pages/show_page/show_episodes.dart';

class ShowSeasons extends StatelessWidget {
  final List<TskgSeason> seasons;

  const ShowSeasons(this.seasons, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _seasons = <Widget>[];
    for (final season in seasons) {
      _seasons.add(
        Text(season.title,
          style: const TextStyle(
            fontSize: 20.0,
          )
        )
      );
      _seasons.add(const SizedBox(height: 12.0));
      _seasons.add(ShowEpisodes(season.episodes));
      _seasons.add(const SizedBox(height: 44.0));
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _seasons,
    );
  }
}