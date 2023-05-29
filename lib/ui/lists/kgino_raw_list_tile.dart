import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../resources/krs_theme.dart';

class KginoRawListTile extends HookWidget {
  final FocusNode focusNode;
  final void Function(FocusNode focusNode)? onFocused;
  final void Function() onTap;

  final String title;
  final String subtitle;
  final String imageUrl;
  final Size imageSize;

  /// кнопки, которые могут отвечать за выбор элемента
  final _selectKeysMap = const [
    LogicalKeyboardKey.enter,
    LogicalKeyboardKey.numpadEnter,
    LogicalKeyboardKey.select,
  ];

  const KginoRawListTile({
    super.key,
    required this.focusNode,
    this.onFocused,
    this.imageSize = const Size(100.0, 140.0),
    required this.onTap,

    this.title = '',
    this.subtitle = '',
    this.imageUrl = '',

  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isMounted = useIsMounted();

    useEffect(() {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          onFocused?.call(focusNode);
        }
      });
      return;
    }, [focusNode]);

    /// цвет свечения
    final glowColor = useState(theme.colorScheme.primary);
    // final dominantColor = useState(theme.colorScheme.surface);

    /// вычисляем цвет свечения
    final calculateGlowColor = useCallback(() async {
      if (imageUrl.isNotEmpty && !imageUrl.endsWith('.svg') && !imageUrl.startsWith('assets/')) {
        /// ^ если изображение есть и оно не векторное

        try {
          /// получаем цветовую палитру фильма
          final palette = await PaletteGenerator.fromImageProvider(
            NetworkImage(imageUrl)
          );

          if (isMounted() && palette.vibrantColor != null) {
            /// обновляем цвет свечения
            glowColor.value = palette.vibrantColor!.color;
          }
        } catch (exception) {
          debugPrint('PaletteGenerator FAIL');
        }
        
      }
    }, [key]);

    final focusState = useState(false);

    return GestureDetector(
      onTap: onTap,
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(
            LogicalKeyboardKey.enter, includeRepeats: false): onTap,
          const SingleActivator(
            LogicalKeyboardKey.select, includeRepeats: false): onTap,
        },

        child: Focus(
          focusNode: focusNode,
          onFocusChange: (hasFocus) {
            /// при получении фокуса
            focusState.value = hasFocus;

            /// вычисляем цвет свечения
            calculateGlowColor();
          },

          onKeyEvent: (node, event) {
            // if (_selectKeysMap.contains(event.logicalKey)) {
            //   /// ^ если была нажата клавиша выбора элемента
            //   _updateHoldedState(event is KeyDownEvent);
            // } else {
            //   _updateHoldedState(false);
            // }
            return KeyEventResult.ignored;
          },
          
          child: SizedBox(
            width: imageSize.width,

            child: AnimatedOpacity(
              duration: KrsTheme.animationDuration,
              opacity: focusState.value ? 1.0 : 0.62,
              
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  /// постер сериала
                  AnimatedScale(
                    duration: KrsTheme.animationDuration,
                    scale: focusNode.hasFocus ? 1.12 : 1.0,
                    child: AnimatedContainer(
                      duration: KrsTheme.animationDuration,
                      width: imageSize.width,
                      height: imageSize.height,
                      decoration: BoxDecoration(
                        boxShadow: [
                          if (focusState.value) BoxShadow(
                            color: glowColor.value.withOpacity(0.62),
                            blurRadius: 22.0,
                            spreadRadius: 2.0
                          ),
                        ],
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(12.0),
                        border: focusState.value
                          ? Border.all(
                              color: theme.colorScheme.onPrimaryContainer,
                              width: 3.0,
                            )
                          : null
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9.0),
                        child: imageUrl.isEmpty
                          ? Opacity(
                            opacity: 0.62,
                            child: SvgPicture.asset('assets/images/kgino_grayscale.svg',
                            ),
                          )
                          : imageUrl.startsWith('assets/')
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(imageUrl),
                            )
                          : imageUrl.endsWith('.svg')
                            ? SvgPicture.network(imageUrl)
                            : Image.network(imageUrl,
                                cacheHeight: imageSize.height.toInt(),
                              ),
                      ),
                    ),
                  ),
                  

                  /// название сериала
                  if (title.isNotEmpty) Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: AnimatedDefaultTextStyle(
                      duration: KrsTheme.animationDuration,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                      child: Text(title,
                        maxLines: subtitle.isEmpty ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  /// дополнительная информация
                  if (subtitle.isNotEmpty) Text(subtitle,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: theme.colorScheme.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),

                ],
              ),

            ),

          ),

        ),
      ),
    );
  }
}
