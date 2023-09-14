import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';
import '../utils.dart';
import 'app_logo.dart';
import 'flmx/flmx_account_dialog.dart';
import 'navigation_bar/krs_tab_bar_search_button.dart';
import 'navigation_bar/krs_tab_bar_button.dart';
import 'navigation_bar/krs_tab_bar_settings_button.dart';

@riverpod
class Tabs extends _$Tabs {
  final focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  int build() {
    return 1;
  }

  void updateSelected(int value) {
    state = value;
  }

  void requestFocus() {
    focusNodes[state.valueOrNull ?? 1].requestFocus();
  }

  void unfocusAll() {
    for (final focusNode in focusNodes) {
      focusNode.unfocus();
    }
  }
}

class ScaffoldWithNavigationBar extends HookConsumerWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(context, ref) {
    final screenSize = MediaQuery.of(context).size;

    final locale = KrsLocale.of(context);

    final focused = useState(false);

    final tabsController = ref.watch(tabsProvider);

    const paddingSize = 24.0;

    return Scaffold(
      endDrawer: SizedBox(
        width: 320.0, //showOverlay.value ? 320.0 : 0,
        height: screenSize.height - 32.0,
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    Utils.showModal(
                      context: context,
                      titleText: 'Аккаунт Filmix',
                      child: const FlmxAccountDialog(),
                    );
                  },
                  title: const Text('Аккаунт Filmix'),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 48.0 + (paddingSize * 2)),
        child: Focus(
          canRequestFocus: false,
          skipTraversal: true,
          onFocusChange: (hasFocus) {
            focused.value = hasFocus;

            if (hasFocus) {
              tabsController.requestFocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: paddingSize,
            ),
            child: Opacity(
              opacity: focused.value ? 1.0 : 0.62,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  AnimatedPositioned(
                    duration: KrsTheme.animationDuration,
                    left:
                        tabsController.state == 0 ? -appLogoWidth : paddingSize,
                    child: AnimatedOpacity(
                      duration: KrsTheme.animationDuration,
                      opacity: tabsController.state == 0 ? 0.0 : 1.0,
                      child: const AppLogo(),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: KrsTheme.animationDuration,
                    left: tabsController.state == 0
                        ? paddingSize
                        : paddingSize + appLogoWidth + 4.0,
                    right: paddingSize,
                    child: Row(
                      children: [
                        // AnimatedOpacity(
                        //   duration: KrsTheme.animationDuration,
                        //   opacity: tabsCubit.state == 0 ? 0.0 : 1.0,
                        //   child: AnimatedContainer(
                        //     duration: KrsTheme.animationDuration,
                        //     margin: EdgeInsetsDirectional.only(
                        //       start: tabsCubit.state == 0 ? 0 : 24.0,
                        //       end: 32.0,
                        //     ),
                        //     width: tabsCubit.state == 0 ? 0 : 58.0,

                        //     child: const AppLogo(),

                        //   ),

                        // ),

                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    KrsTabBarSearchButton(
                                      index: 0,
                                      onPressed: () {},
                                    ),
                                    const SizedBox(width: 4.0),
                                    KrsTabBarButton(
                                      index: 1,
                                      onPressed: () {},
                                      label: Text(locale.shows),
                                    ),
                                    const SizedBox(width: 4.0),
                                    KrsTabBarButton(
                                      index: 2,
                                      onPressed: () {},
                                      label: Text(locale.movies),
                                    ),
                                    const SizedBox(width: 4.0),
                                    KrsTabBarButton(
                                      index: 3,
                                      onPressed: () {},
                                      label: Text(locale.cameras),
                                    ),
                                  ],
                                ),
                              ),

                              /// кнопка входа в настройки
                              const KrsTabBarSettingsButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: child,
    );
  }
}
