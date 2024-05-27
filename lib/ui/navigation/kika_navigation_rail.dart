import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import '../../extensions/context_extensions.dart';
import '../../pages/settings_page/settings_page.dart';
import '../../providers/locale_provider.dart';
import '../application_logo.dart';
import 'kika_navigation_tile.dart';

class KikaNavigationRail extends StatefulWidget {
  final FocusNode focusNode;
  final PageController pageController;

  const KikaNavigationRail({
    super.key,
    required this.focusNode,
    required this.pageController,
  });

  @override
  State<KikaNavigationRail> createState() => KikaNavigationRailState();
}

class KikaNavigationRailState extends State<KikaNavigationRail> {
  static const minWidth = 80.0;
  static const expandedWidth = 280.0;

  List<FocusNode> _focusNodes = [];
  int _focusedItemIndex = 0;
  bool _expanded = false;
  bool _visible = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _focusedItemIndex = widget.pageController.page?.toInt() ?? 0;
      });
    });

    widget.pageController.addListener(_handlePageChanged);

    _focusNodes = List.generate(5, (index) => FocusNode());
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_handlePageChanged);
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final locale = Locale.of(context);

    /// навигационные ссылки
    final navigations = [
      NavigationItem(
        title: 'Поиск',
        icon: const Icon(Iconsax.search_normal_1),
      ),
      NavigationItem(
        title: 'Сериалы',
        icon: const Icon(Iconsax.video_play),
      ),
      NavigationItem(
        title: 'Фильмы',
        icon: const Icon(Iconsax.video_square),
      ),
      NavigationItem(
        title: 'Камеры',
        icon: const Icon(Iconsax.video),
      ),
    ];

    return Focus(
      focusNode: widget.focusNode,
      canRequestFocus: _expanded,
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          animateToCurrent();
        }
      },
      onKeyEvent: (node, event) {
        if (HardwareKeyboard.instance
            .isLogicalKeyPressed(LogicalKeyboardKey.arrowRight)) {
          closeDrawer();
          return KeyEventResult.handled;
        }

        if (HardwareKeyboard.instance
            .isLogicalKeyPressed(LogicalKeyboardKey.arrowUp)) {
          goPrevious();
          return KeyEventResult.handled;
        }

        if (HardwareKeyboard.instance
            .isLogicalKeyPressed(LogicalKeyboardKey.arrowDown)) {
          return goNext();
        }

        return KeyEventResult.ignored;
      },
      child: Stack(
        children: [
          /// затемнение для боковой панели в свёрнутом состоянии
          // AnimatedOpacity(
          //   duration: kThemeAnimationDuration * 2,
          //   curve: Curves.easeOut,
          //   opacity: _visible ? 1.0 : 0.0,
          //   // offset: _expanded ? Offset.zero : const Offset(-2.0, 0.0),
          //   child: SizedBox(
          //     width: minWidth,
          //     height: double.infinity,
          //     child: DecoratedBox(
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           begin: Alignment.centerLeft,
          //           end: Alignment.centerRight,
          //           colors: [
          //             theme.colorScheme.surface,
          //             theme.colorScheme.surface.withOpacity(0.0),
          //           ],
          //           stops: const [0.0, 1.0],
          //           tileMode: TileMode.decal,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          /// затемнение для боковой панели в развёрнутом состоянии
          AnimatedContainer(
            duration: kThemeAnimationDuration,
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              gradient: _expanded
                  ? LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        theme.colorScheme.surface,
                        theme.colorScheme.surface.withOpacity(0.0),
                      ],
                      //stops: const [0.0, 1.0],
                    )
                  : null,
            ),
          ),

          /// анимации появления/скрытия боковой панели
          AnimatedSlide(
            duration: kThemeAnimationDuration * 2,
            curve: Curves.easeOut,
            offset: _visible ? Offset.zero : const Offset(-1.0, 0.0),
            child: AnimatedOpacity(
              duration: kThemeAnimationDuration * 2,
              curve: Curves.easeIn,
              opacity: _visible ? 1.0 : 0.0,

              /// боковая панель
              child: AnimatedContainer(
                duration: kThemeAnimationDuration,
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                width: _expanded ? expandedWidth : minWidth,

                /// затемнение для боковой панели в свёрнутом состоянии
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      theme.colorScheme.surface,
                      theme.colorScheme.surface.withOpacity(0.0),
                    ],
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.decal,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24.0),

                    /// верхний виджет боковой панели
                    /// (виден только в развёрнутом состоянии)
                    SizedBox(
                      height: 28.0,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: AnimatedSlide(
                          duration: kThemeAnimationDuration,
                          curve: Curves.easeOut,
                          offset: _expanded
                              ? Offset.zero
                              : const Offset(-1.25, 0.0),
                          child: const ApplicationLogo(),
                        ),
                      ),
                    ),

                    /// основные навигационные ссылки
                    Expanded(
                      child: Center(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return KikaNavigationTile(
                              focusNode: _focusNodes[index],
                              title: Text(navigations[index].title),
                              onTap: () {
                                //animateTo(index);
                                closeDrawer();
                              },
                              icon: navigations[index].icon,
                              focused: _focusedItemIndex == index,
                              selected:
                                  widget.pageController.page!.toInt() == index,
                              expanded: _expanded,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12.0),
                        ),
                      ),
                    ),

                    /// нижний виджет боковой панели
                    /// (виден только в развёрнутом состоянии)
                    AnimatedSlide(
                      duration: kThemeAnimationDuration,
                      curve: Curves.easeOut,
                      offset: _expanded ? Offset.zero : const Offset(-2.0, 0.0),
                      child: KikaNavigationTile(
                        focusNode: _focusNodes[4],
                        onTap: () async {
                          await context.showStartModal(
                            titleText: locale.settings,
                            child: const SettingsPage(),
                          );
                        },
                        title: const Text('Настройки'),
                        icon: const Icon(Iconsax.setting_2),
                        expanded: _expanded,
                      ),
                    ),

                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// переходим к предыдущему элементу
  KeyEventResult goPrevious() {
    // if (!_animationComplete) return KeyEventResult.handled;

    if (_focusedItemIndex > 0) {
      _focusedItemIndex--;
      animateToCurrent();
      return KeyEventResult.handled;
    } else {
      // widget.onMoveUp?.call();
      // return widget.onMoveUp != null
      //     ? KeyEventResult.handled
      //     : KeyEventResult.ignored;
      return KeyEventResult.skipRemainingHandlers;
    }
  }

  /// переходим к следующему элементу
  KeyEventResult goNext() {
    // if (!_animationComplete) return KeyEventResult.handled;

    if (_focusedItemIndex < 4) {
      _focusedItemIndex++;
      animateToCurrent();

      return KeyEventResult.handled;
    } else {
      // widget.onMoveUp?.call();
      // return widget.onMoveDown != null
      //     ? KeyEventResult.handled
      //     : KeyEventResult.ignored;
      return KeyEventResult.skipRemainingHandlers;
    }
  }

  /// перейти к активной ссылке навигационной панели
  void animateToCurrent() async {
    if (_focusedItemIndex < 4) {
      widget.pageController.animateToPage(
        _focusedItemIndex,
        duration: kThemeAnimationDuration,
        curve: Curves.easeInOut,
      );
    }
    requestCurrentFocus();
  }

  /// перейти к указанной ссылке навигационной панели
  void animateTo(int index) {
    if (_focusedItemIndex != index) {
      _focusedItemIndex = index;
      animateToCurrent();
    }
  }

  /// запрос фокуса на текущей активной ссылке навигационной панели
  void requestCurrentFocus() {
    setState(() {
      _focusNodes[_focusedItemIndex].requestFocus();
    });
  }

  /// раскрыть навигационную панель
  void openDrawer() {
    setState(() {
      _expanded = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.focusNode.focusInDirection(TraversalDirection.left);
    });
  }

  /// свернуть навигационную панель
  void closeDrawer() {
    if (_focusedItemIndex > 3) {
      animateTo(3);
    }

    setState(() {
      _expanded = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.focusNode.focusInDirection(TraversalDirection.right);
    });
  }

  /// показать свёрнутую навигационную панель
  void showDrawer() {
    setState(() {
      _visible = true;
    });
  }

  /// скрыть свёрнутую навигационную панель
  void hideDrawer() {
    setState(() {
      _visible = false;
    });
  }

  /// обработчик событий смены страницы
  void _handlePageChanged() {
    setState(() {});
  }
}

class NavigationItem {
  final String title;
  final Widget icon;

  NavigationItem({required this.title, required this.icon});
}
