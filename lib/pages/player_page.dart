import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kgino/ui/player/youtube_player_view.dart';
import 'package:video_player/video_player.dart';

import '../models/media_item.dart';
import '../models/media_item_url.dart';
import '../providers/providers.dart';
import '../ui/player/player_controls_overlay.dart';
import '../utils.dart';

class PlayerPage extends ConsumerStatefulWidget {
  final MediaItem mediaItem;
  final int episodeIndex;

  /// начальная позиция просмотра видео
  final int initialPosition;

  /// обновление позиции без вопроса пользователю
  /// например, при смене качества видео
  final bool forcePositionUpdate;

  const PlayerPage({
    super.key,
    required this.mediaItem,
    this.episodeIndex = 0,
    this.initialPosition = 0,
    this.forcePositionUpdate = false,
  });
  @override
  ConsumerState createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  late MediaItemUrl _mediaItemUrl;
  VideoPlayerController _controller = VideoPlayerController.networkUrl(Uri());
  String _youtubeUrl = '';

  late List<MediaItemEpisode> episodes;

  /// проигрываемый эпизод
  late MediaItemEpisode playableEpisode;

  /// индекс текущего сезона
  int currentSeasonIndex = 0;

  /// индекс текущего эпизода
  int currentEpisodeIndex = 0;

  /// null - нет субтитров, true - включены, false - выключены
  bool? hasSubtitles;

  bool _menuOpened = false;

  @override
  void initState() {
    super.initState();

    episodes = widget.mediaItem.episodes;
    currentEpisodeIndex = widget.episodeIndex;
    playableEpisode = episodes[currentEpisodeIndex];

    // /// загружаем видео и субтитры
    // widget.mediaItem.loadEpisodeUrl(ref, playableEpisode).then((mediaItemUrl) {
    //   debugPrint('Loaded episode url: $mediaItemUrl');
    //
    //   /// открываем ссылку на проигрываемый файл
    //   player.open(Media(mediaItemUrl.video)).then((value) async {
    //     /// дожидаемся буферизации
    //     await player.stream.buffer.first;
    //
    //     // if (widget.initialPosition > 0) {
    //     //   /// ^ если задана позиция просмотра и быстрая перемотка
    //     //
    //     //   /// дожидаемся буферизации
    //     //   await player.stream.buffer.first;
    //     //
    //     //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //     //     player.pause();
    //     //
    //     //     // ignore: use_build_context_synchronously
    //     //     // bool updatePosition = widget.forcePositionUpdate;
    //     //     // if (!updatePosition) {
    //     //     //   setState(() {
    //     //     //     _menuOpened = true;
    //     //     //   });
    //     //     //
    //     //     //   updatePosition = await Utils.showConfirmModal(
    //     //     //     context: context,
    //     //     //     title: 'Продолжить просмотр?',
    //     //     //     message:
    //     //     //         'Продолжить просмотр с момента, на котором Вы завершили просмотр прошлый раз',
    //     //     //     child: Column(
    //     //     //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //     //     //       children: [
    //     //     //         HookBuilder(
    //     //     //           builder: (context) {
    //     //     //             final focused = useState(false);
    //     //     //
    //     //     //             return AnimatedScale(
    //     //     //               duration: kThemeAnimationDuration,
    //     //     //               scale: focused.value ? 1.1 : 1.0,
    //     //     //               child: FilledButton(
    //     //     //                 autofocus: true,
    //     //     //                 onFocusChange: (hasFocus) {
    //     //     //                   focused.value = hasFocus;
    //     //     //                 },
    //     //     //                 onPressed: () {
    //     //     //                   if (mounted) {
    //     //     //                     Navigator.of(context).pop(true);
    //     //     //                   }
    //     //     //                 },
    //     //     //                 child: Text('Продолжить'),
    //     //     //               ),
    //     //     //             );
    //     //     //           },
    //     //     //         ),
    //     //     //         const SizedBox(height: 12.0),
    //     //     //         HookBuilder(
    //     //     //           builder: (context) {
    //     //     //             final focused = useState(false);
    //     //     //
    //     //     //             return AnimatedScale(
    //     //     //               duration: kThemeAnimationDuration,
    //     //     //               scale: focused.value ? 1.1 : 1.0,
    //     //     //               child: FilledButton(
    //     //     //                 onFocusChange: (hasFocus) {
    //     //     //                   focused.value = hasFocus;
    //     //     //                 },
    //     //     //                 onPressed: () {
    //     //     //                   if (mounted) {
    //     //     //                     Navigator.of(context).pop(false);
    //     //     //                   }
    //     //     //                 },
    //     //     //                 child: Text('Начать с начала'),
    //     //     //               ),
    //     //     //             );
    //     //     //           },
    //     //     //         ),
    //     //     //       ],
    //     //     //     ),
    //     //     //   );
    //     //     //
    //     //     //   setState(() {
    //     //     //     _menuOpened = false;
    //     //     //   });
    //     //     // }
    //     //     //
    //     //     // if (updatePosition == true) {
    //     //     //   /// перематываем с небольшой отмоткой назад
    //     //     //   await player.seek(
    //     //     //     Duration(
    //     //     //       seconds: widget.initialPosition > 2
    //     //     //           ? widget.initialPosition - 2
    //     //     //           : widget.initialPosition,
    //     //     //     ),
    //     //     //   );
    //     //     // }
    //     //
    //     //     player.play();
    //     //   });
    //     // }
    //   });
    //
    //   if (mediaItemUrl.subtitles.isNotEmpty) {
    //     /// ^ если есть файл субтитров
    //
    //     // setState(() {
    //     //   hasSubtitles = widget.mediaItem.subtitles;
    //     // });
    //
    //     /// загружаем субтитры
    //     if (hasSubtitles == true) {
    //       player.setSubtitleTrack(
    //         SubtitleTrack.uri(
    //           mediaItemUrl.subtitles,
    //           language: 'ru',
    //         ),
    //       );
    //     }
    //   }
    // });

    /// загружаем видео и субтитры
    widget.mediaItem.loadEpisodeUrl(ref, playableEpisode).then((mediaItemUrl) {
      _mediaItemUrl = mediaItemUrl;

      if (_mediaItemUrl.video.startsWith('https://www.youtube.com/')) {
        setState(() {
          _youtubeUrl = _mediaItemUrl.video;
        });
      } else {
        if (mediaItemUrl.hasSubtitles) {
          /// ^ если есть файл субтитров

          hasSubtitles = widget.mediaItem.subtitlesEnabled;
        }

        /// подчищаем старый контроллер видео
        _controller.dispose();

        /// инициализируем контроллер видео
        _controller = VideoPlayerController.networkUrl(
          Uri.parse(mediaItemUrl.video),
          closedCaptionFile: mediaItemUrl.loadSubtitlesFile(),
        )..initialize().then((_) async {
            if (widget.initialPosition > 0) {
              /// ^ если задана позиция просмотра и быстрая перемотка

              // /// останавливаем воспроизведение
              // _controller?.pause();
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                bool updatePosition = widget.forcePositionUpdate;
                if (!updatePosition) {
                  setState(() {
                    _menuOpened = true;
                  });

                  updatePosition = await Utils.showConfirmModal(
                    context: context,
                    title: 'Продолжить просмотр?',
                    message:
                        'Продолжить просмотр с момента, на котором Вы завершили просмотр прошлый раз',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HookBuilder(
                          builder: (context) {
                            final focused = useState(false);

                            return AnimatedScale(
                              duration: kThemeAnimationDuration,
                              scale: focused.value ? 1.1 : 1.0,
                              child: FilledButton(
                                autofocus: true,
                                onFocusChange: (hasFocus) {
                                  focused.value = hasFocus;
                                },
                                onPressed: () {
                                  if (mounted) {
                                    Navigator.of(context).pop(true);
                                  }
                                },
                                child: Text('Продолжить'),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12.0),
                        HookBuilder(
                          builder: (context) {
                            final focused = useState(false);

                            return AnimatedScale(
                              duration: kThemeAnimationDuration,
                              scale: focused.value ? 1.1 : 1.0,
                              child: FilledButton(
                                onFocusChange: (hasFocus) {
                                  focused.value = hasFocus;
                                },
                                onPressed: () {
                                  if (mounted) {
                                    Navigator.of(context).pop(false);
                                  }
                                },
                                child: Text('Начать с начала'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );

                  setState(() {
                    _menuOpened = false;
                  });
                }

                if (updatePosition == true) {
                  /// перематываем с небольшой отмоткой назад
                  await _controller?.seekTo(
                    Duration(
                      seconds: widget.initialPosition > 2
                          ? widget.initialPosition - 2
                          : widget.initialPosition,
                    ),
                  );
                }

                setState(() {
                  _controller.play();
                });
              });
            } else {
              setState(() {
                _controller.play();
              });
            }
          }, onError: (exception) {
            /// ^ если возникла ошибка инициализации видео
            setState(() {});
          });
      }
    });
  }

  @override
  void deactivate() {
    /// ставим на паузу, если виджет деактивирован

    super.deactivate();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  /// есть ли предыдущие эпизоды
  bool get hasPreviousEpisode => (currentEpisodeIndex > 0);

  /// есть ли следующий эпизод
  bool get hasNextEpisode => (currentEpisodeIndex + 1 < episodes.length);

  /// обработчик переключения на предыдущий эпизод
  void skipPrevious() {
    currentEpisodeIndex--;

    /// переходим на страницу плеера фильма
    updateEpisode();
  }

  /// обработчик переключения на следующий эпизод
  void skipNext() {
    currentEpisodeIndex++;

    /// переходим на страницу плеера фильма
    updateEpisode();
  }

  void updateEpisode({
    int position = 0,
    bool forcePositionUpdate = false,
  }) {
    /// переходим на страницу плеера фильма
    context.pushReplacementNamed(
      'player',
      queryParameters: {
        'episodeIndex': '$currentEpisodeIndex',
        'initialPosition': '$position',
        'forcePositionUpdate': '$forcePositionUpdate',
      },
      extra: widget.mediaItem,
    );
  }

  @override
  Widget build(context) {
    if (_youtubeUrl.isNotEmpty) {
      return YoutubePlayerView(url: _youtubeUrl);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const SizedBox(),
          ),
          PlayerControlsOverlay(
            key: ObjectKey(_controller),
            controller: _controller,
            title: widget.mediaItem.title,
            subtitle: widget.mediaItem.isShow
                ? 'Сезон ${playableEpisode.seasonNumber} Эпизод ${playableEpisode.episodeNumber}'
                : '',

            /// плейлист
            onSkipPrevious: hasPreviousEpisode ? skipPrevious : null,
            onSkipNext: hasNextEpisode ? skipNext : null,
            onSavePositionRequested: (position) {
              /// обновляем (если нужно) продолжительность эпизода
              if (playableEpisode.duration == 0) {
                playableEpisode.duration = _controller.value.duration.inSeconds;
              }

              /// обновляем позицию просмотра для проигрываемого эпизода
              playableEpisode.position = position;

              /// сохраняем параметры проигрываемого эпизода
              playableEpisode.save(ref.read(storageProvider));
            },

            /// субтитры
            hasSubtitles: hasSubtitles,
            onSubtitlesChanged: (enabled) {
              /// обновляем информацию о субтитрах
              widget.mediaItem.subtitlesEnabled = enabled;
              widget.mediaItem.save(ref.read(storageProvider));

              if (enabled) {
                /// загружаем субтитры
                _controller
                    .setClosedCaptionFile(_mediaItemUrl.loadSubtitlesFile());
              } else {
                /// убираем субтитры
                _controller.setClosedCaptionFile(null);
              }
            },

            /// качество видео
            qualities: playableEpisode.qualities
                .sorted((a, b) => compareNatural(b, a)),
            quality: widget.mediaItem.quality,
            onQualityChanged: (quality) {
              /// обновляем информацию о качестве видео
              widget.mediaItem.quality = quality;
              widget.mediaItem.save(ref.read(storageProvider));

              /// перезапускаем эпизод
              updateEpisode(
                position: _controller.value.position.inSeconds,
                forcePositionUpdate: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
