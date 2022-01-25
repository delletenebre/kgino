import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_season.dart';
import 'package:kgino/ui/pages/show_page/show_episodes.dart';

class ShowSeasons extends StatelessWidget {
  final List<TskgSeason> seasons;

  const ShowSeasons(this.seasons, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _seasons = seasons.map((season) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(season.title),
          
          ShowEpisodes(season.episodes),
        ],
      );
    }).toList();


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: double.maxFinite,), ..._seasons,
      ],
    );
  }
}