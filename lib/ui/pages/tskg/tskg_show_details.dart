import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/movie_item.dart';
import '../../../models/tskg/tskg_show.dart';
import '../../../resources/krs_locale.dart';
import '../../krs_chip.dart';

class TskgShowDetais extends StatelessWidget {
  final TskgMovieItem show;
  final bool expanded;

  const TskgShowDetais({
    super.key,
    required this.show,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);
    final size = MediaQuery.of(context).size;
    
    /// определяем ширину постера на фоне
    final width = (size.width < 420.0) ? size.width + (size.width * 0.1) : 420.0;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [

        /// постер фильма
        Positioned(
          /// отступ вверх, на размер навигационной панели
          top: -72.0 - 120.0,
          right: 0,

          width: width,
          // странный хак, без этого ShaderMask режет картинку
          // либо убрать верхний отступ
          height: size.height - 32.0,

          child: ShaderMask(
            blendMode: BlendMode.dstOut,
            shaderCallback: (rect) {
              return const RadialGradient(
                center: Alignment.topRight,
                radius: 1.05,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
                stops: [0.25, 1.0],
              ).createShader(rect);
            },

            /// постер сериала
            child: CachedNetworkImage(
              imageUrl: show.posterUrl,
              fit: BoxFit.cover,
            ),
          ),

        ),

        Positioned(
          top: 0.0,
          left: 0.0,

          /// размер описания на 62% от ширины экрана
          width: size.width * 0.62,
          
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// название сериала
                Text(show.name,
                  style: theme.textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                /// оригинальное название фильма
                if (expanded && show.originalName.isNotEmpty) Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(show.originalName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8)
                    ),
                    child: Row(
                      children: [

                        /// год выпуска, жанры (оставляем не более двух)
                        Text([ show.year, ... show.genres.take(2) ].join(', ')),

                        const SizedBox(width: 12.0),

                        /// количество эпизодов (файлов), если сериал
                        Text(locale.seasonsCount(show.seasons.length)),

                        const SizedBox(width: 12.0),

                        /// страны фильма (оставляем не более двух)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(show.countries.take(2).join(', ')),
                        ),

                        if (show.voiceActing.isNotEmpty) Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: KrsChip(
                            dense: true,
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(Icons.mic),
                                ),
                                
                                Text(show.voiceActing),
                              ],
                            ),
                          ),
                        ),
                        
                      ],
                    )
                  ),
                ),

                /// озвучка
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      
                    ],
                  ),
                ),

                /// описание сериала
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(show.description,
                    maxLines: expanded ? 10 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              ],
            ),
          ),
        ),
        
      ],
    );
  }
}
