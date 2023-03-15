import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/flmx/flmx_details_controller.dart';
import '../../models/api_response.dart';
import '../../models/movie_item.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../../ui/krs_scroll_view.dart';
import '../../ui/loading_indicator.dart';
import '../../ui/pages/movie_details_view.dart';
import '../../ui/pages/play_button_seen_information.dart';
import '../../ui/pages/try_again_message.dart';
import '../../utils.dart';


class FlmxDetailsPage extends StatefulWidget {
  final String id;

  const FlmxDetailsPage(this.id, {
    super.key,
  });

  @override
  State<FlmxDetailsPage> createState() => _FlmxDetailsPageState();
}

class _FlmxDetailsPageState extends State<FlmxDetailsPage> {
  final _scrollController = ScrollController();
  bool _isScrolling = false;

  final _playButtonFocusNode = FocusNode();
  late final void Function() _playButtonListener;

  @override
  void initState() {
    _playButtonListener = () {
      if (mounted) {
        setState(() {
          
        });
      }
    };
    
    _playButtonFocusNode.addListener(_playButtonListener);

    super.initState();
  }

  @override
  void dispose() {
    _playButtonFocusNode.removeListener(_playButtonListener);
    _playButtonFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final locale = KrsLocale.of(context);

    return Scaffold(
      body: BlocProvider(
        create: (context) => FlmxDetailsController(widget.id)..fetchDetails(),
        child: BlocBuilder<FlmxDetailsController, ApiResponse<MovieItem>>(
          builder: (context, state) {

            if (state.isLoading) {
              return const LoadingIndicator();
            }

            if (state.isEmpty || state.isError) {
              return TryAgainMessage(
                onRetry: () {
                  
                }
              );
            }

            final movieItem = state.asData.data;

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
                  height: MediaQuery.of(context).size.height - (128.0 + 72.0),
                  child: MovieDetaisView(movieItem,
                    expanded: true,
                    posterOffset: const Offset(0.0, -400),
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
                    padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              /// если кнопка Смотреть в фокусе
                              if (_playButtonFocusNode.hasFocus) PlayButtonSeenInformation(
                                itemKey: movieItem.storageKey,
                                movieItem: movieItem,
                                showEpisodeNumber: false,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8.0),
                        
                        SizedBox(
                          height: 40.0,
                          child: Row(
                            children: [

                              /// кнопка начала просмотра
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton.icon(
                                  focusNode: _playButtonFocusNode,
                                  autofocus: true,
                                  style: KrsTheme.filledTonalButtonStyleOf(context),
                                  onPressed: () {
                                    /// переходим на страницу плеера фильма
                                    context.goNamed('flmxPlayer',
                                      params: {
                                        'id': movieItem.id,
                                      },
                                      queryParams: {
                                        'episodeId': movieItem.seasons.first.episodes.first.id,
                                      },
                                      extra: movieItem,
                                    );
                                  },
                                  icon: const Icon(Icons.play_arrow),
                                  label: Text(locale.play),
                                ),
                              ),

                              /// если файлов несколько, показываем кнопку выбора
                              /// эпизода
                              if (movieItem.seasons.first.episodes.length > 1) Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilledButton.tonalIcon(
                                  onPressed: () {
                                    /// переходим на страницу выбора файла
                                    context.goNamed('flmxFiles',
                                      params: {
                                        'id': movieItem.id,
                                      },
                                      extra: movieItem,
                                    );
                                  },
                                  icon: const Icon(Icons.folder_open),
                                  label: Text(locale.selectEpisode),
                                ),
                              ),

                              /// если есть трейлер, показываем кнопку просмотра
                              /// трейлера
                              // if (movie.trailer != null) Padding(
                              //   padding: const EdgeInsets.only(right: 8.0),
                              //   child: ElevatedButton.icon(
                              //     style: KrsTheme.filledTonalButtonStyleOf(context),
                              //     onPressed: () {
                              //       /// проигрывам трейлер фильма
                              //       context.push('/player',
                              //         extra: PlayableItem(
                              //           id: '%%%trailer%%%',
                              //           videoUrl: movie.trailer!.video,
                              //           title: movie.name,
                              //           subtitle: locale.trailer,
                              //         ),
                              //       );
                              //     },
                              //     icon: const Icon(Icons.videocam),
                              //     label: Text(locale.trailer),
                              //   ),
                              // ),

                              /// кнопка выбора озвучки
                              if (movieItem.voiceActingIds.isNotEmpty) Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilledButton.tonalIcon(
                                  onPressed: () {
                                    Utils.showModal(
                                      context: context,
                                      titleText: 'Выбор аудио',
                                      child: ListView(
                                        children: [

                                          SizedBox(
                                            width: 320.0,
                                            child: FilledButton.tonalIcon(
                                              autofocus: true,
                                              icon: const Icon(Icons.check),
                                              label: Text(movieItem.voiceActing),
                                              onPressed: () => Navigator.pop(context),
                                            ),
                                          ),

                                          ... movieItem.voiceActingIds.where((voiceActingId) {
                                            return voiceActingId != movieItem.voiceActing;
                                          }).map((voiceActing) {
                                            return FilledButton.tonal(
                                              child: Text(voiceActing),
                                              onPressed: () {
                                                Navigator.pop(context);

                                                // /// переходим на страницу деталей о сериале
                                                // context.replaceNamed('tskgShowDetails',
                                                //   params: {
                                                //     'id': item.id,
                                                //   },
                                                // );
                                              },
                                            );
                                          }).toList(),

                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.mic),
                                  label: const Text('Выбрать озвучку'),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}
