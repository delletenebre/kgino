import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/movie_item.dart';
import '../../resources/krs_locale.dart';
import '../../ui/lists/krs_horizontal_list_view.dart';
import '../../ui/pages/episode_card.dart';


class OckgMovieFilesPage extends StatefulWidget {
  final MovieItem movie;

  const OckgMovieFilesPage({
    super.key,
    required this.movie,
  });

  @override
  State<OckgMovieFilesPage> createState() => _OckgMovieFilesPageState();
}

class _OckgMovieFilesPageState extends State<OckgMovieFilesPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(112.0 + 24.0 + 18.0 + 8.0),
          child: KrsHorizontalListView(
            //controller: _episodesScrollController,
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            spacing: 24.0,
            itemCount: widget.movie.seasons.first.episodes.length,
            itemBuilder: (context, focusNode, index) {
              final episode = widget.movie.seasons.first.episodes[index];

              /// просмотренное время [0; 1]
              double seenValue = 0.0;
              // final seenEpisode = seenEpisodesController.findEpisode(
              //   tag: SeenItem.tskgTag,
              //   itemId: widget.show.showId,
              //   episodeId: episode.id,
              // );

              // if (seenEpisode != null) {
              //   seenValue = seenEpisode.percentPosition;
              // }

              return EpisodeCard(
                focusNode: focusNode,
                titleText: episode.name,
                //description: '${episode.quality} ${Utils.formatDuration(episode.duration)}',

                /// время просмотра
                seenValue: seenValue,

                onPressed: () {
                  /// переходим на страницу плеера фильма
                  context.goNamed('ockgMoviePlayer',
                    params: {
                      'id': widget.movie.id,    
                    },
                    queryParams: {
                      'episodeId': episode.id,
                    },
                    extra: widget.movie,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
