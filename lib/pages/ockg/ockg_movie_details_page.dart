import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../models/video_player_item.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../../ui/krs_scroll_view.dart';
import '../../ui/loading_indicator.dart';
import '../../ui/pages/try_again_message.dart';
import '../../ui/pages/ockg/ockg_movie_details.dart';


class OckgMovieDetailsPage extends StatefulWidget {
  final int movieId;

  const OckgMovieDetailsPage(this.movieId, {
    super.key,
  });

  @override
  State<OckgMovieDetailsPage> createState() => _OckgMovieDetailsPageState();
}

class _OckgMovieDetailsPageState extends State<OckgMovieDetailsPage> {
  final _scrollController = ScrollController();
  bool _isScrolling = false;

  @override
  Widget build(BuildContext context) {

    final locale = KrsLocale.of(context);

    print('MediaQuery.of(context).size.height ${MediaQuery.of(context).size.height - (32 * 2 + 40)}');
    
    return Scaffold(
      body: BlocProvider(
        create: (context) => OckgMovieDetailsController(
          movieId: widget.movieId,
        ),
        child: BlocBuilder<OckgMovieDetailsController, RequestState<OckgMovie>>(
          builder: (context, state) {
            if (state.isError || state.isEmpty) {
              return TryAgainMessage(
                onRetry: () {
                  
                }
              );
            }
            
            if (state.isSuccess) {
              final movie = state.data;
              return KrsScrollView(
                scrollController: _scrollController,
                onStartScroll: (scrollMetrics) {
                  _isScrolling = true;
                },
                onEndScroll: (scrollMetrics) {
                  _isScrolling = false;
                },
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 72.0),
                    height: MediaQuery.of(context).size.height - (32 * 2 + 40 + 72.0),
                    child: OckgMovieDetais(
                      movie: movie,
                      expanded: true,
                    ),
                  ),

                  Focus(
                    skipTraversal: true,
                    onKey: (node, event) {
                      if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
                        if (!_isScrolling) {
                          _scrollController.animateTo(0.0,
                            duration: KrsTheme.animationDuration,
                            curve: Curves.easeIn,
                          );
                        }
                      }

                      return KeyEventResult.ignored;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Row(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton(
                              autofocus: true,
                              style: KrsTheme.filledTonalButtonStyleOf(context),
                              onPressed: () {
                                context.push('/player',
                                  extra: VideoPlayerItem(
                                    videoUrl: movie.files.first.path.replaceFirst('/home/video/', 'https://p1.oc.kg:8082/'),
                                    title: movie.name,
                                  ),
                                );
                              },
                              child: Text(locale.play)
                            ),
                          ),

                          if (movie.trailer != null) Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton(
                              style: KrsTheme.filledTonalButtonStyleOf(context),
                              onPressed: () {
                                context.push('/player',
                                  extra: VideoPlayerItem(
                                    videoUrl: movie.trailer!.video,
                                    title: movie.name,
                                    subtitle: locale.trailer,
                                  ),
                                );
                              },
                              child: Text(locale.trailer)
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  if (movie.files.length > 1) SizedBox(
                    height: 300,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie.files.length,
                      itemBuilder: (context, index) {
                        final file = movie.files[index];

                        return InkWell(
                          onTap: () {
                            print(file);
                          },
                          child: Card(
                            child: Text(file.name),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 24.0,);
                      },
                    ),
                  )

                ],
              );
            }

            return const LoadingIndicator();
          },
        ),
      ),
    );
  }
}
