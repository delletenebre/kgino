import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_episode.dart';

class ShowEpisodes extends StatelessWidget {
  final List<TskgEpisode> episodes;

  const ShowEpisodes(this.episodes, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: episodes.map((episode) {
        return Text(episode.title);
      }).toList(),
    );
  }
}