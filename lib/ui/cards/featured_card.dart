import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/media_item.dart';
import '../../resources/constants.dart';

class FeaturedCard extends HookWidget {
  final MediaItem mediaItem;

  const FeaturedCard(
    this.mediaItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // /// цвет свечения
    // final glowColor = useState(theme.colorScheme.outline);
    // final isMounted = useIsMounted();

    final animationController = useAnimationController(
      duration: kThemeAnimationDuration,
    );
    final positionAnimation = useAnimation<double>(Tween(
      begin: -TvUi.featuredHeight - 40.0,
      end: 40.0,
    ).animate(animationController));
    final opacityAnimation = useAnimation<double>(Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController));

    /// вычисляем цвет свечения
    useEffect(() {
      animationController.forward();

      /// we could optionally return some "dispose" logic here
      return null;
    }, const []);

    return Stack(
      children: [
        Positioned(
          bottom: positionAnimation,
          left: TvUi.hPadding,
          child: SizedBox(
            width: TvUi.featuredSize.width,
            child: Opacity(
              opacity: opacityAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        children: [
                          Text(
                            [
                              mediaItem.genresString,
                              mediaItem.year,
                              mediaItem.countriesString,
                            ].join(' • '),
                            //'Superhero/Action • 2022 • 2h 15m'
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    mediaItem.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 32.0,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    reverseDuration: Duration.zero,
                    transitionBuilder: (child, animation) {
                      final fadeAnimation = Tween<double>(
                        begin: 0.0, // Fully transparent
                        end: 1.0, // Fully opaque
                      ).animate(animation);

                      final slideAnimation = Tween<Offset>(
                        begin: const Offset(
                            0.0, 1.0), // Start from below the widget
                        end: const Offset(
                            0.0, 0.0), // End at its original position
                      ).animate(animation);

                      final sizeAnimation = Tween<double>(
                        begin: 0.0, // Start with zero size
                        end: 1.0, // End with full size
                      ).animate(animation);

                      return SizeTransition(
                        sizeFactor: sizeAnimation,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: mediaItem.mayBeOverview.isNotEmpty
                        ? Padding(
                            key: UniqueKey(),
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              mediaItem.mayBeOverview,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
