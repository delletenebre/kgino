import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../resources/constants.dart';

class FeaturedCard extends HookWidget {
  final String title;
  final String imageUrl;

  const FeaturedCard({
    super.key,
    this.title = '',
    this.imageUrl = '',
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
                            'Superhero/Action • 2022 • 2h 15m',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 32.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      'A dynamic duo of superhero siblings join forces to save their city from a sinister villain, redefining sisterhood in action.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
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
