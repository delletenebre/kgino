import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../../ui/loading_indicator.dart';
import '../../ui/pages/empty_item_message.dart';
import '../../ui/pages/ockg/ockg_movie_details.dart';


class OckgMovieDetailsPage extends StatelessWidget {
  final int movieId;

  const OckgMovieDetailsPage(this.movieId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final locale = KrsLocale.of(context);
    
    return Scaffold(
      body: BlocProvider(
        create: (context) => OckgMovieDetailsController(
          movieId: movieId,
        ),
        child: BlocBuilder<OckgMovieDetailsController, RequestState<OckgMovie>>(
          builder: (context, state) {
            if (state.isError || state.isEmpty) {
              return EmptyItemMessage(
                onRetry: () {
                  
                }
              );
            }
            
            if (state.isSuccess) {
              final movie = state.data;
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: SizedBox(
                      height: 40.0,
                    ),
                  ),

                  Expanded(
                    child: OckgMovieDetais(
                      movie: movie,
                      expanded: true,
                    ),
                  ),

                  Padding(
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
                                extra: movie.files.first.path.replaceFirst('/home/video/', 'https://p1.oc.kg:8082/'),
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
                                extra: movie.trailer!.video
                              );
                            },
                            child: Text(locale.trailer)
                          ),
                        ),

                      ],
                    ),
                  ),
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
