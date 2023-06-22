import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kgino/resources/krs_theme.dart';

import '../../resources/krs_locale.dart';
import '../../utils.dart';
import '../flmx/flmx_account_dialog.dart';

class KrsTabBarSettingsButton extends HookWidget {
  const KrsTabBarSettingsButton({
    super.key,
  });

  @override
  Widget build(context) {
    final locale = KrsLocale.of(context);

    final showOverlay = useState(false);

    final screenSize = MediaQuery.of(context).size;

    return Focus(
      skipTraversal: true,
      onFocusChange: (hasFocus) {
        showOverlay.value = hasFocus;
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          
          Positioned(
            top: -8.0,
            right: 16.0,
            child: AnimatedScale(
              alignment: Alignment.topRight,
              duration: KrsTheme.animationDuration,
              scale: showOverlay.value ? 1.0 : 0.0,
              child: SizedBox(
                width: 320.0, //showOverlay.value ? 320.0 : 0,
                height: screenSize.height - 32.0,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 48.0,
                      left: 24.0,
                      right: 24.0,
                      bottom: 24.0,
                    ),
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
                        // ListTile(
                        //   onTap: () {
                            
                        //   },
                        //   title: Text('Setting 2'),
                        // ),
                        // ListTile(
                        //   onTap: () {
                            
                        //   },
                        //   title: Text('Setting 3'),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: IconButton(
              tooltip: locale.settings,
              onPressed: () {
                /// показываем/скрываем страницу настроек
                showOverlay.value = !showOverlay.value;
              },
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
    );
  }
}