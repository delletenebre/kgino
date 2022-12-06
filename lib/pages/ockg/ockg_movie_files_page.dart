import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../models/playable_item.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../../ui/krs_scroll_view.dart';
import '../../ui/lists/krs_horizontal_list_view.dart';
import '../../ui/loading_indicator.dart';
import '../../ui/pages/episode_card.dart';
import '../../ui/pages/try_again_message.dart';
import '../../ui/pages/ockg/ockg_movie_details.dart';
import '../../utils.dart';


class OckgMovieFilesPage extends StatefulWidget {
  final OckgMovie movie;

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

    final locale = KrsLocale.of(context);

    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(112.0 + 24.0 + 18.0 + 8.0),
          child: KrsHorizontalListView(
            //controller: _episodesScrollController,
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            spacing: 24.0,
            itemCount: widget.movie.files.length,
            itemBuilder: (context, focusNode, index) {
              final episode = widget.movie.files[index];

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
                  /// переходим на страницу плеера сериала
                  // context.goNamed('tskgPlayer',
                  //   params: {
                  //     'id': widget.show.showId,    
                  //   },
                  //   queryParams: {
                  //     'startTime': 0.toString(),
                  //     'episodeId': episode.id.toString(),
                  //     'episodeIndex': index.toString(),
                  //   },
                  //   extra: widget.show,
                  // );
                  /// переходим на страницу плеера фильма
                  context.goNamed('ockgMoviePlayer',
                    params: {
                      'id': '${widget.movie.movieId}',    
                    },
                    queryParams: {
                      'fileIndex': index.toString(),
                      'fileId': episode.fileId.toString(),
                    },
                    extra: widget.movie,
                  );
                },
              );
            },
          ),
        ),
        
        // SizedBox.fromSize(
        //   size: const Size.fromHeight(112.0 + 24.0 + 18.0 + 8.0),
        //   child: ListView.separated(
        //     clipBehavior: Clip.none,
        //     controller: _autoScrollController,
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 48.0,
        //     ),
        //     scrollDirection: Axis.horizontal,
        //     itemCount: widget.movie.files.length,
        //     itemBuilder: (context, index) {
        //       final file = widget.movie.files[index];

        //       return AutoScrollTag(
        //         key: ValueKey(index), 
        //         controller: _autoScrollController,
        //         index: index,
        //         child: EpisodeCard(
        //           titleText: file.name,
        //           onFocused: (node) {
        //             /// ^ при смене фокуса на этот фильм
                
        //             /// прокручиваем контент к текущему элементу
        //             _autoScrollController.scrollToIndex(index,
        //               preferPosition: AutoScrollPosition.begin,
        //               duration: KrsTheme.fastAnimationDuration,
        //             );
        //           },
        //           onPressed: () {
        //             /// переходим на страницу плеера фильма
        //             context.goNamed('ockgMoviePlayer',
        //               params: {
        //                 'id': '${widget.movie.movieId}',    
        //               },
        //               queryParams: {
        //                 'startTime': 0.toString(),
        //                 'fileIndex': index.toString(),
        //               },
        //               extra: widget.movie,
        //             );
        //           },
                  
        //         ),
                
        //       );
        //     },
        //     separatorBuilder: (context, index) {
        //       return const SizedBox(width: 24.0);
        //     },
            
        //   ),
        // ),
      ),
    );
  }
}
// OckgMovieCard(
//   // поставить ли фокус на первый фильм в списке
//   autofocus: (index == 0 && widget.autofocus),
//   focusNode: widget.focusNodes?[index],
//   // данные о фильме
//   movie: movie,

//   onMovieFocused: (movie, focusNode) {
//     // ^ при смене фокуса на этот фильм
    
//     /// прокручиваем контент к текущему элементу
//     _autoScrollController.scrollToIndex(index,
//       preferPosition: AutoScrollPosition.begin,
//       duration: const Duration(milliseconds: 50),
//     ).then((_) {
//       // ^ после окончания прокрутки
      
//       if (mounted) {
//         // ^ если виджет ещё жив
        
//         // вызываем пользовательский обработчик
//         widget.onMovieFocused.call(movie);
//       }
//     });
//   },
// ),