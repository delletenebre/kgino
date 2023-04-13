import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kgino/resources/krs_theme.dart';

import '../../resources/krs_locale.dart';

class KrsTabBarSettingsButton extends HookWidget {
  const KrsTabBarSettingsButton({
    super.key,
  });

  @override
  Widget build(context) {
    final theme = Theme.of(context);
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
            top: 0.0,
            right: 24.0,
            child: AnimatedContainer(
              duration: KrsTheme.animationDuration,
              width: showOverlay.value ? 320.0 : 0,
              height: showOverlay.value ? screenSize.height - 48.0 : 0,
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

                        },
                        title: Text('Setting 1'),
                      ),
                      ListTile(
                        onTap: () {
                          
                        },
                        title: Text('Setting 2'),
                      ),
                      ListTile(
                        onTap: () {
                          
                        },
                        title: Text('Setting 3'),
                      )
                    ],
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
                /// показываем страницу настроек
                showOverlay.value = true;
              },
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
    );
  }
}