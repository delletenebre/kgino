import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../resources/constants.dart';

class MediaCard extends HookWidget {
  final String title;
  final String imageUrl;
  final void Function()? onFocused;
  final void Function()? onTap;

  const MediaCard({
    super.key,
    this.title = '',
    this.imageUrl = '',
    this.onFocused,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final focused = useState(false);

    /// цвет свечения
    final glowColor = useState(theme.colorScheme.outline);
    final isMounted = useIsMounted();

    /// вычисляем цвет свечения
    useEffect(() {
      if (imageUrl.isNotEmpty &&
          !imageUrl.endsWith('.svg') &&
          !imageUrl.startsWith('assets/')) {
        /// ^ если изображение есть и оно не векторное

        try {
          /// получаем цветовую палитру изобоажения
          PaletteGenerator.fromImageProvider(NetworkImage(imageUrl))
              .then((palette) {
            if (isMounted() && palette.vibrantColor != null) {
              /// обновляем цвет свечения
              glowColor.value = palette.vibrantColor!.color;
            }
          });
        } catch (exception) {
          debugPrint('PaletteGenerator FAIL');
        }
      }

      /// we could optionally return some "dispose" logic here
      return null;
    }, const []);

    return Focus(
      onFocusChange: (hasFocus) {
        /// при получении фокуса
        focused.value = hasFocus;

        if (hasFocus) {
          onFocused?.call();
        }
      },
      child: AnimatedScale(
        duration: kThemeAnimationDuration,
        scale: focused.value ? 1.1 : 1.0,
        child: AnimatedContainer(
          duration: kThemeAnimationDuration,
          clipBehavior: Clip.antiAlias,
          width: TvUi.horizontalCardSize.width,
          height: TvUi.horizontalCardSize.height,
          foregroundDecoration: BoxDecoration(
            border: focused.value
                ? Border.all(
                    color: theme.colorScheme.outline,
                    width: 3.0,
                  )
                : null,
            borderRadius: BorderRadius.circular(12.0),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              if (focused.value)
                BoxShadow(
                  color: glowColor.value,
                  blurRadius: 24.0,
                  // spreadRadius: 2.0,
                ),
            ],
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12.0),
            border: focused.value
                ? Border.all(
                    width: 3.0,
                  )
                : null,
          ),
          child: Stack(
            children: [
              /// постер сериала
              Positioned.fill(
                child: Container(
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        theme.colorScheme.surface,
                        Colors.transparent,
                      ],
                      stops: const [0.1, 1.0],
                    ),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    //'https://image.tmdb.org/t/p/w500/id0gCbEij0NItwKpoEhL2TR0KT6.jpg',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'Subtitle • 2023',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
