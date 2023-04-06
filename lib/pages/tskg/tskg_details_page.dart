import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../api/tskg_api_provider.dart';
import '../../controllers/kgino_item_details_cubit.dart';
import '../../models/api_response.dart';
import '../../models/kgino_item.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../../ui/app_header.dart';
import '../../ui/kgino_item/bookmark_button.dart';
import '../../ui/kgino_item/voice_actings_button.dart';
import '../../ui/kgino_item/krs_item_details.dart';
import '../../ui/krs_scroll_view.dart';
import '../../ui/kgino_item/play_button_tooltip.dart';
import '../../ui/loading_indicator.dart';
import '../../ui/try_again_message.dart';


class TskgDetailsPage extends HookWidget {
  final String kginoItemId;
  final secondContainerKey = GlobalKey();

  TskgDetailsPage(this.kginoItemId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final locale = KrsLocale.of(context);

    /// размер экрана
    final screenSize = MediaQuery.of(context).size;

    /// провайдер запросов к API
    final api = GetIt.instance<TskgApiProvider>();

    /// контроллер расширенной информации о фильме
    final detailsCubit = KginoItemDetailsCubit();

    final scrollController = useScrollController();
    final isScrolling = useState(false);

    final playButtonHasFocus = useState(false);
    final secondContainerPosition = useState(0.0);

    /// вычисляем позицию второго контейнера, если он есть
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final box = secondContainerKey.globalPaintBounds;
      if (box != null) {
        secondContainerPosition.value = box.top;
      }
    });

    return Scaffold(
      body: BlocProvider<KginoItemDetailsCubit>(
        create: (context) => detailsCubit..fetch(api.getShowDetails(kginoItemId)),
        child: BlocBuilder<KginoItemDetailsCubit, ApiResponse<KginoItem>>(
          builder: (context, state) {
                    
            if (state.isError || state.isEmpty) {
              return TryAgainMessage(
                onRetry: () {
                  /// запрашиваем данные ещё раз
                  context.read<KginoItemDetailsCubit>()
                    .fetch(api.getShowDetails(kginoItemId));
                }
              );
            }

            if (state.isLoading) {
              return const LoadingIndicator();
            }
            
            final kginoItem = state.asData.data;

            return KrsScrollView(
              scrollController: scrollController,
              onStartScroll: (scrollMetrics) {
                isScrolling.value = true;
              },
              onEndScroll: (scrollMetrics) {
                isScrolling.value = false;
              },
              children: [
                /// заголовок
                const AppHeader(
                  child: Text('TS.KG'),
                ),

                SizedBox(
                  height: screenSize.height - KrsTheme.appBarHeight,
                  child: Stack(
                    children: [
                      KrsItemDetails(state,
                        expanded: true,
                      ),

                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Focus(
                          canRequestFocus: false,
                          skipTraversal: true,
                          onFocusChange: (hasFocus) {
                            if (hasFocus && !isScrolling.value) {
                              scrollController.animateTo(0.0,
                                duration: KrsTheme.animationDuration,
                                curve: Curves.easeIn,
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 32.0),
                            child: Column(
                              
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    /// если кнопка Смотреть в фокусе
                                    if (playButtonHasFocus.value) PlayButtonTooltip(kginoItem,
                                      showEpisodeNumber: false,
                                    ),

                                  ],
                                ),

                                const SizedBox(height: 8.0),
                                
                                Row(
                                  children: [

                                    /// кнопка начала просмотра
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      child: FilledButton.icon(
                                        autofocus: true,
                                        onFocusChange: (hasFocus) {
                                          playButtonHasFocus.value = hasFocus;
                                        },
                                        onPressed: () {
                                          /// переходим на страницу плеера фильма
                                          context.pushNamed('tskgPlayer',
                                            params: {
                                              'id': kginoItem.id,
                                            },
                                            queryParams: {
                                              'episodeId': kginoItem.seasons.first.episodes.first.id,
                                            },
                                            extra: kginoItem,
                                          );
                                        },
                                        icon: const Icon(Icons.play_arrow),
                                        label: Text(locale.play),
                                      ),
                                    ),

                                    /// если файлов несколько, показываем кнопку выбора
                                    /// эпизода
                                    if (kginoItem.seasons.first.episodes.length > 1) Padding(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      child: FilledButton.icon(
                                        onPressed: () {
                                          /// переходим на страницу выбора файла
                                          context.pushNamed('tskgEpisodes',
                                            params: {
                                              'id': kginoItem.id,
                                            },
                                            extra: kginoItem,
                                          );
                                        },
                                        icon: const Icon(Icons.folder_open),
                                        label: Text(locale.selectEpisode),
                                      ),
                                    ),

                                    /// кнопка добавления или удаления из закладок
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      child: BookmarkButton(kginoItem),
                                    ),

                                    /// кнопка выбора озвучки
                                    if (kginoItem.voiceActings.length > 1) Padding(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      child: VoiceActingsButton(kginoItem,
                                        onVoiceActingChange: (voiceActing) async {
                                          /// переходим на страницу деталей о сериале
                                          // TODO fix route to movie
                                          context.pushReplacementNamed('tskgDetails',
                                            params: {
                                              'id': voiceActing.id,
                                            },
                                          );
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Focus(
                //   key: secondContainerKey,
                //   canRequestFocus: false,
                //   skipTraversal: true,
                //   onFocusChange: (hasFocus) {
                //     if (hasFocus && !isScrolling.value) {
                //       scrollController.animateTo(secondContainerPosition.value,
                //         duration: KrsTheme.animationDuration,
                //         curve: Curves.easeIn,
                //       );
                //     }
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(24.0),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [

                //         Container(
                //           height: MediaQuery.of(context).size.height,
                //           child: FilledButton(
                //             onPressed: () {

                //             },
                //             child: Text('button 3'),
                //           ),
                //         ),

                //       ],
                //     ),
                //   ),
                // ),

              ],
            );
          },
        ),
      ),
    );
  }
}


extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final matrix = renderObject?.getTransformTo(null);

    if (matrix != null && renderObject?.paintBounds != null) {
      final rect = MatrixUtils.transformRect(matrix, renderObject!.paintBounds);
      return rect;
    } else {
      return null;
    }
  }
}