import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../controllers/seen_items_controller.dart';
import '../../controllers/tskg/tskg_show_details_controller.dart';
import '../../models/episode_item.dart';
import '../../models/movie_item.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../../ui/krs_scroll_view.dart';
import '../../ui/loading_indicator.dart';
import '../../ui/pages/play_button_seen_information.dart';
import '../../ui/pages/try_again_message.dart';
import '../../ui/pages/tskg/tskg_show_details.dart';
import '../../utils.dart';


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
    debugPrint('build $this');
    
    final locale = KrsLocale.of(context);

    /// контроллер просмотренных эпизодов
    final seenItemsController = GetIt.instance<SeenItemsController>();

    return Scaffold(
      body: BlocProvider(
        create: (context) => TskgShowDetailsController(
          showId: widget.showId,
        ),
        child: BlocBuilder<TskgShowDetailsController, RequestState<TskgMovieItem>>(
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
                    height: MediaQuery.of(context).size.height - (128.0 + 72.0),
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
                                  itemKey: show.storageKey,
                                  movieItem: show,
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
                                ValueListenableBuilder(
                                  valueListenable: seenItemsController.listenable,
                                  builder: (context, box, child) {
                                    final seenItem = seenItemsController.findItemByKey(
                                      show.storageKey
                                    );

                                    if (seenItem == null || seenItem.episodes.isEmpty) {
                                      /// ^ если сериал ещё не был просмотрен
                                      
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: ElevatedButton.icon(
                                          autofocus: true,
                                          style: KrsTheme.filledTonalButtonStyleOf(context),
                                          onPressed: () {
                                            /// переходим на страницу плеера сериала
                                            context.goNamed('tskgPlayer',
                                              params: {
                                                'id': show.id,    
                                              },
                                              queryParams: {
                                                'episodeId': show.seasons.first.episodes.first.id,
                                              },
                                              extra: show,
                                            );
                                          },
                                          icon: const Icon(Icons.play_arrow),
                                          label: Text(locale.play),
                                        ),
                                      );
                                      
                                    } else {
                                      /// ^ если у сериала есть просмотреные серии
                                      
                                      /// получаем последний просмотренный эпизод
                                      final seenEpisode = seenItem.getLastSeenEpisode()!;

                                      /// получаем эпизод, с которого нужно продолжить просмотр
                                      final playableEpisode = show.getNextPlayableEpisode(seenEpisode);

                                      return Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: ElevatedButton.icon(
                                          focusNode: _playButtonFocusNode,
                                          autofocus: true,
                                          style: KrsTheme.filledTonalButtonStyleOf(context),
                                          onPressed: () {
                                            /// переходим на страницу плеера сериала
                                            context.goNamed('tskgPlayer',
                                              params: {
                                                'id': show.id,    
                                              },
                                              queryParams: {
                                                'episodeId': playableEpisode.id,
                                              },
                                              extra: show,
                                            );
                                          },
                                          icon: const Icon(Icons.play_arrow),
                                          label: Text(locale.play),
                                        ),
                                      );
                                    }
                                    
                                  }
                                ),

                                /// кнопка выбора эпизода
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton.icon(
                                    style: KrsTheme.filledTonalButtonStyleOf(context),
                                    onPressed: () {
                                      /// переходим на страницу выбора эпизода
                                      context.goNamed('tskgShowSeasons',
                                        params: {
                                          'id': show.id,
                                        },
                                        extra: show,
                                      );
                                    },
                                    icon: const Icon(Icons.folder_open),
                                    
                                    /// если сезонов несколько "выбрать сезон", иначе
                                    /// "выбрать серию"
                                    label: Text(show.seasons.length > 1
                                        ? locale.selectSeason : locale.selectEpisode
                                    ),
                                  ),
                                ),

                                ValueListenableBuilder(
                                  valueListenable: seenItemsController.listenable,
                                  builder: (context, Box<MovieItem> box, _) {
                                    if (seenItemsController.hasFavorite(show)) {
                                      /// ^ если уже добавлен в избранное
                                      
                                      /// кнопка удаления из избранного
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: ElevatedButton.icon(
                                          style: KrsTheme.filledTonalButtonStyleOf(context),
                                          onPressed: () {
                                            /// убираем из избранного
                                            seenItemsController.removeFavorite(show);
                                          },
                                          icon: const Icon(Icons.bookmark_remove),
                                          label: Text(locale.removeFromFavorites),
                                        ),
                                      );
                                      
                                    } else {
                                      /// ^ если ещё нет в избранном

                                      /// кнопка добавления в избранное
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: ElevatedButton.icon(
                                          style: KrsTheme.filledTonalButtonStyleOf(context),
                                          onPressed: () {
                                            /// добавляем в избранное
                                            seenItemsController.addFavorite(show);
                                          },
                                          icon: const Icon(Icons.bookmark_add_outlined),
                                          label: Text(locale.addToFavorites),
                                        ),
                                      );
                                    }
                                  }
                                ),

                                /// кнопка выбора озвучки
                                if (show.voiceActings.isNotEmpty) Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton.icon(
                                    style: KrsTheme.filledTonalButtonStyleOf(context),
                                    onPressed: () {
                                      Utils.showModal(
                                        context: context,
                                        titleText: 'Выбор аудио',
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            SizedBox(
                                              width: 320.0,
                                              child: ElevatedButton.icon(
                                                autofocus: true,
                                                style: KrsTheme.filledTonalButtonStyleOf(context),
                                                icon: const Icon(Icons.check),
                                                label: Text(show.voiceActing),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ),

                                            ... show.voiceActings.map((item) {
                                              return SizedBox(
                                                width: 320.0,
                                                child: ElevatedButton(
                                                  style: KrsTheme.filledTonalButtonStyleOf(context),
                                                  child: Text(item.name),
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    /// переходим на страницу деталей о сериале
                                                    context.replaceNamed('tskgShowDetails',
                                                      params: {
                                                        'id': item.id,
                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                            }).toList(),

                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.mic),
                                    label: Text('Выбрать озвучку'),
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
            }

            return const LoadingIndicator(
              size: 64.0,
            );
          },
        ),
      ),
    );
  }
}
