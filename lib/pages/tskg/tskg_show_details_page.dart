import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../controllers/tskg/tskg_show_details_controller.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../models/playable_item.dart';
import '../../models/tskg/tskg_show.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../../ui/krs_scroll_view.dart';
import '../../ui/krs_tooltip.dart';
import '../../ui/loading_indicator.dart';
import '../../ui/pages/try_again_message.dart';
import '../../ui/pages/ockg/ockg_movie_details.dart';
import '../../ui/pages/tskg/tskg_show_details.dart';


class TskgShowDetailsPage extends StatefulWidget {
  final String showId;

  const TskgShowDetailsPage(this.showId, {
    super.key,
  });

  @override
  State<TskgShowDetailsPage> createState() => _TskgShowDetailsPageState();
}

class _TskgShowDetailsPageState extends State<TskgShowDetailsPage> {
  final _scrollController = ScrollController();
  bool _isScrolling = false;

  @override
  Widget build(BuildContext context) {

    final locale = KrsLocale.of(context);

    return Scaffold(
      body: BlocProvider(
        create: (context) => TskgShowDetailsController(
          showId: widget.showId,
        ),
        child: BlocBuilder<TskgShowDetailsController, RequestState<TskgShow>>(
          builder: (context, state) {
            if (state.isError || state.isEmpty) {
              return TryAgainMessage(
                onRetry: () {
                  
                }
              );
            }
            
            if (state.isSuccess) {
              final show = state.data;
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
                    child: TskgShowDetais(
                      show: show,
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

                          /// кнопка начала просмотра
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton.icon(
                              autofocus: true,
                              style: KrsTheme.filledTonalButtonStyleOf(context),
                              onPressed: () {
                                /// переходим на страницу плеера фильма
                                context.goNamed('tskgMoviePlayer',
                                  params: {
                                    'id': show.showId,
                                  },
                                  queryParams: {
                                    'startTime': '0',
                                    'fileIndex': '0',
                                  },
                                  extra: show,
                                );
                              },
                              icon: const Icon(Icons.play_arrow),
                              label: Text(locale.play),
                            ),
                          ),

                          /// если файлов несколько, показываем кнопку выбора
                          /// эпизода
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton.icon(
                              style: KrsTheme.filledTonalButtonStyleOf(context),
                              onPressed: () {
                                /// переходим на страницу выбора файла
                                context.goNamed('tskgShowFiles',
                                  params: {
                                    'id': show.showId,
                                  },
                                  extra: show,
                                );
                              },
                              icon: const Icon(Icons.folder_open),
                              label: Text(locale.selectSeason),
                            ),
                          ),

                          /// если файлов несколько, показываем кнопку выбора
                          /// эпизода
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton.icon(
                              style: KrsTheme.filledTonalButtonStyleOf(context),
                              onPressed: () {
                                /// добавляем в избранное
                                
                              },
                              icon: const Icon(Icons.bookmark_add_outlined),
                              label: Text(locale.addToFavorites),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton.icon(
                              style: KrsTheme.filledTonalButtonStyleOf(context),
                              onPressed: () {
                                /// убираем из избранного
                                
                              },
                              icon: const Icon(Icons.bookmark_remove_outlined),
                              label: Text(locale.removeFromFavorites),
                            ),
                          ),

                          // /// если есть трейлер, показываем кнопку просмотра
                          // /// трейлера
                          // if (show.trailer != null) Padding(
                          //   padding: const EdgeInsets.only(right: 8.0),
                          //   child: ElevatedButton(
                          //     style: KrsTheme.filledTonalButtonStyleOf(context),
                          //     onPressed: () {
                          //       /// проигрывам трейлер фильма
                          //       context.push('/player',
                          //         extra: PlayableItem(
                          //           videoUrl: show.trailer!.video,
                          //           title: show.name,
                          //           subtitle: locale.trailer,
                          //         ),
                          //       );
                          //     },
                          //     child: Text(locale.trailer)
                          //   ),
                          // ),

                        ],
                      ),
                    ),
                  ),

                  // if (movie.files.length > 1) SizedBox(
                  //   height: 300,
                  //   child: ListView.separated(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: movie.files.length,
                  //     itemBuilder: (context, index) {
                  //       final file = movie.files[index];

                  //       return InkWell(
                  //         onTap: () {
                  //           print(file);
                  //         },
                  //         child: Card(
                  //           child: Text(file.name),
                  //         ),
                  //       );
                  //     },
                  //     separatorBuilder: (context, index) {
                  //       return const SizedBox(width: 24.0,);
                  //     },
                  //   ),
                  // )

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
