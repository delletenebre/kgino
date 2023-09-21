import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kgino/extensions/duration.dart';

import '../../models/api_response.dart';
import '../../models/kgino_item.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';

class KrsItemDetails extends HookWidget {
  final ApiResponse<KginoItem> state;
  final bool expanded;

  const KrsItemDetails(
    this.state, {
    super.key,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    // if (state.isLoading || state.isEmpty || state.isError) {
    if (!state.isSuccess) {
      return const SizedBox(
        height: KrsTheme.movieDetailsHeight,
      );
    }

    /// детали фильма или сериала
    final kginoItem = state.asData.data;

    final opacity = useState(0.0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      opacity.value = 1.0;
    });

    return AnimatedOpacity(
      opacity: opacity.value,
      duration: KrsTheme.animationDuration,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const SizedBox(width: double.maxFinite),
          if (kginoItem.posterUrl.isNotEmpty &&
              !kginoItem.posterUrl.endsWith('.svg'))
            Positioned(
              top: -KrsTheme.appBarHeight,
              right: 0.0,
              child: RepaintBoundary(
                child: Opacity(
                  opacity: 0.62,
                  child: ShaderMask(
                    blendMode: BlendMode.dstOut,
                    shaderCallback: (rect) {
                      return const RadialGradient(
                        center: Alignment.topRight,
                        radius: 1.0,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        stops: [0.25, 1.0],
                      ).createShader(rect);
                    },

                    /// постер фильма
                    child: Image.network(
                      kginoItem.posterUrl,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            width: MediaQuery.of(context).size.width * 0.62,
            height: expanded ? null : KrsTheme.movieDetailsHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// название фильма
                Text(
                  kginoItem.name,
                  style: theme.textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                /// оригинальное название фильма
                // if (expanded && kginoItem.originalName.isNotEmpty) Padding(
                //   padding: const EdgeInsets.only(top: 4.0),
                //   child: Text(kginoItem.originalName,
                //     style: theme.textTheme.titleMedium?.copyWith(
                //       color: theme.colorScheme.outline,
                //     ),
                //     maxLines: 1,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 14.0,
                        color: theme.textTheme.bodyMedium?.color
                            ?.withOpacity(0.8)),
                    child: Row(
                      children: [
                        /// год выпуска, жанры (оставляем не более двух)
                        Text([kginoItem.year, ...kginoItem.genres.take(2)]
                            .join(', ')),

                        const SizedBox(width: 12.0),

                        /// продолжительность фильма (или общая для сериала)
                        if (kginoItem.seasons.isNotEmpty &&
                            kginoItem.seasons.first.episodes.length == 1 &&
                            kginoItem.duration.inSeconds == 0)
                          Text(locale.episodesCount(
                              kginoItem.seasons.first.episodes.length)),

                        /// продолжительность фильма (или общая для сериала)
                        if (kginoItem.seasons.isNotEmpty &&
                            kginoItem.seasons.first.episodes.length == 1 &&
                            kginoItem.duration.inSeconds > 0)
                          Text(kginoItem.duration.formatted),

                        /// количество эпизодов (файлов), если сериал
                        if (kginoItem.seasons.isNotEmpty &&
                            kginoItem.seasons.length > 1 &&
                            kginoItem.seasons.first.episodes.length > 1)
                          Text(locale.seasonsCount(kginoItem.seasons.length)),

                        /// количество эпизодов (файлов), если сериал
                        if (kginoItem.seasons.isNotEmpty &&
                            kginoItem.seasons.length == 1 &&
                            kginoItem.seasons.first.episodes.length > 1)
                          Text(locale.episodesCount(
                              kginoItem.seasons.first.episodes.length)),

                        const SizedBox(width: 12.0),

                        /// страны фильма (оставляем не более двух)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(kginoItem.countries.take(2).join(', ')),
                        ),

                        /// если звук 5.1
                        // if (movie.hasSixChannels) Padding(
                        //   padding: const EdgeInsets.only(right: 8.0),
                        //   child: KrsChip(
                        //     dense: true,
                        //     child: Row(
                        //       children: const [
                        //         Padding(
                        //           padding: EdgeInsets.only(right: 4.0),
                        //           child: Icon(Icons.volume_up),
                        //         ),

                        //         Text('5.1'),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),

                /// рейтинги фильма
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      /// рейтинг IMDb
                      if (kginoItem.hasImdbRating)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: KginoRatingChip(
                            name: 'IMDb',
                            rating: kginoItem.imdbRating,
                          ),
                        ),

                      /// рейтинг КиноПоиск
                      if (kginoItem.hasKinopoiskRating)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: KginoRatingChip(
                            name: 'КиноПоиск',
                            rating: kginoItem.kinopoiskRating,
                          ),
                        ),

                      /// озвучка
                      if (kginoItem.voiceActing.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: KrsItemDetailsChip(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    Icons.mic,
                                    size: 16.0,
                                  ),
                                ),
                                Text(kginoItem.shortVoiceActing),
                              ],
                            ),
                          ),
                        ),

                      /// качество видео
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 8.0),
                      //   child: KrsChip(
                      //     child: Text(movie.quality),
                      //   ),
                      // ),

                      /// ограничения к просмотру
                      // if (movie.mpaa.isNotEmpty) Padding(
                      //   padding: const EdgeInsets.only(right: 8.0),
                      //   child: KrsChip(
                      //     child: Text(movie.mpaa),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                /// описание фильма
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    kginoItem.description,
                    maxLines: expanded ? 10 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KrsItemDetailsChip extends StatelessWidget {
  final Widget child;

  const KrsItemDetailsChip({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      label: child,
      labelStyle: const TextStyle(
        fontSize: 12.0,
      ),
    );
  }
}

class KginoRatingChip extends StatelessWidget {
  final String name;
  final double rating;

  const KginoRatingChip({
    super.key,
    required this.name,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color? textColor;

    if (rating <= 5.5) {
      textColor = theme.colorScheme.error;
    }

    if (rating >= 7.5) {
      textColor = Colors.green;
    }

    return KrsItemDetailsChip(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name),
        const Text(': '),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    ));
  }
}
