import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kgino/resources/krs_theme.dart';

import '../../providers/navigation.dart';
import '../../resources/constants.dart';
import '../../resources/krs_locale.dart';
import '../../utils.dart';

class KrsNavigationBarSettingsButton extends HookConsumerWidget {
  const KrsNavigationBarSettingsButton({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final showOverlay = useState(false);
    final focusNode = useFocusNode();

    final screenSize = MediaQuery.of(context).size;

    final overlayController = useState(OverlayPortalController());

    final tabsController = ref.read(navigationProvider.notifier);

    return Focus(
      skipTraversal: true,
      onFocusChange: (hasFocus) {
        //showOverlay.value = hasFocus;
        if (hasFocus && !overlayController.value.isShowing) {
          overlayController.value.show();
          showOverlay.value = true;
          focusNode.requestFocus();
        } else {
          overlayController.value.hide();
          showOverlay.value = false;
          tabsController.requestCurrentActiveTabFocus();
        }
      },

      child: OverlayPortal(
        controller: overlayController.value,
        overlayChildBuilder: (context) {
          return HookBuilder(
            builder: (context) {
              final animationController = useAnimationController(
                duration: kThemeAnimationDuration,
              );

              // /// цвет текста
              // final colorAnimation = useAnimation<Color?>(ColorTween(
              //   begin: theme.colorScheme.onSurfaceVariant,
              //   end: theme.colorScheme.onSecondaryContainer,
              // ).animate(animationController));

              // /// цвет фона
              // final backgroundColorAnimation = useAnimation<Color?>(ColorTween(
              //   begin: theme.colorScheme.surface,
              //   end: theme.colorScheme.secondaryContainer,
              // ).animate(animationController));

              final widthAnimation = useAnimation<double?>(Tween<double>(
                begin: 0.0,
                end: 320.0,
              ).animate(animationController));

              final heightAnimation = useAnimation<double?>(Tween<double>(
                begin: 0.0,
                end: MediaQuery.of(context).size.height,
              ).animate(animationController));

              final scaleAnimation = useAnimation<double?>(Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(animationController));

              animationController.animateTo(1.0);

              return Stack(
                children: [
                  Positioned(
                    right: 0, //positionRightAnimation,
                    top: 0, //positionTopAnimation,
                    child: Transform.scale(
                      alignment: Alignment.center,
                      scale: scaleAnimation,
                      origin: const Offset(
                        320.0 / 2.0 - TvUi.hPadding - 12.0,
                        -TvUi.vPadding - 14.0,
                      ),
                      child: Material(
                        color: theme.colorScheme.primaryContainer,
                        //color: Colors.transparent,
                        child: Container(
                          width: 320.0,
                          //height: heightAnimation,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: TvUi.hPadding + 8.0,
                                  top: TvUi.vPadding + 4.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(locale.settings),
                                    const Icon(Icons.settings_outlined),
                                  ],
                                ),
                              ),
                              ListTile(
                                focusNode: focusNode,
                                onTap: () {},
                                title: Text('Аккаунт Filmix'),
                              ),
                              ListTile(
                                onTap: () {},
                                title: Text('Аккаунт Filmix 3'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: IconButton(
          tooltip: locale.settings,
          onPressed: () {
            /// показываем/скрываем страницу настроек
            //showOverlay.value = !showOverlay.value;
            //Scaffold.of(context).openEndDrawer();
          },
          icon: const Icon(Icons.settings_outlined),
        ),
      ),
      // child: Stack(
      //   clipBehavior: Clip.none,
      //   children: [
      //     Positioned(
      //       right: 0.0,
      //       top: 0.0,
      //       bottom: 0.0,
      //       child: AnimatedScale(
      //         alignment: Alignment.topRight,
      //         duration: KrsTheme.animationDuration,
      //         scale: showOverlay.value ? 1.0 : 0.0,
      //         child: Material(
      //           color: theme.colorScheme.primaryContainer,
      //           child: Container(
      //             width: 240.0,
      //             height: 240.0,
      //             child: Column(
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     children: [
      //                       Text(locale.settings),
      //                       const Icon(Icons.settings),
      //                     ],
      //                   ),
      //                 ),
      //                 ListTile(
      //                   focusNode: focusNode,
      //                   onTap: () {},
      //                   title: Text('Аккаунт Filmix'),
      //                 ),
      //                 ListTile(
      //                   onTap: () {},
      //                   title: Text('Аккаунт Filmix 3'),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     IconButton(
      //       tooltip: locale.settings,
      //       onPressed: () {
      //         /// показываем/скрываем страницу настроек
      //         //showOverlay.value = !showOverlay.value;
      //         //Scaffold.of(context).openEndDrawer();
      //       },
      //       icon: const Icon(Icons.settings_outlined),
      //     ),
      //   ],
      // ),
    );

    // Positioned(
    //   top: -8.0,
    //   right: 16.0,
    //   child: AnimatedScale(
    //     alignment: Alignment.topRight,
    //     duration: KrsTheme.animationDuration,
    //     scale: showOverlay.value ? 1.0 : 0.0,
    //     child: SizedBox(
    //       width: 320.0, //showOverlay.value ? 320.0 : 0,
    //       height: screenSize.height - 32.0,
    //       child: Card(
    //         elevation: 8.0,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(28.0),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.only(
    //             top: 48.0,
    //             left: 24.0,
    //             right: 24.0,
    //             bottom: 24.0,
    //           ),
    //           child: ListView(
    //             children: [
    //               ListTile(
    //                 onTap: () {
    //                   Utils.showModal(
    //                     context: context,
    //                     titleText: 'Аккаунт Filmix',
    //                     child: const FlmxAccountDialog(),
    //                   );
    //                 },
    //                 title: const Text('Аккаунт Filmix'),
    //               ),
    //               // ListTile(
    //               //   onTap: () {

    //               //   },
    //               //   title: Text('Setting 2'),
    //               // ),
    //               // ListTile(
    //               //   onTap: () {

    //               //   },
    //               //   title: Text('Setting 3'),
    //               // )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // ),

    //       IconButton(
    //         tooltip: locale.settings,
    //         onPressed: () {
    //           /// показываем/скрываем страницу настроек
    //           showOverlay.value = !showOverlay.value;
    //           Scaffold.of(context).openEndDrawer();
    //         },
    //         icon: const Icon(Icons.settings_outlined),
    //       ),
    //     ],
    //   ),
    // );
  }
}
