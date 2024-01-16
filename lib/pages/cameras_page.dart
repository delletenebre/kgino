import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/kg_camera_api_provider.dart';
import '../models/category_list_item.dart';
import '../models/media_item.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';
import '../ui/cards/media_item_card.dart';
import '../ui/images/online_service_logo.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';

class CamerasPage extends HookConsumerWidget {
  const CamerasPage({super.key});

  @override
  Widget build(context, ref) {
    /// сохраняем состояние страницы между переходами [PageView]
    useAutomaticKeepAlive();

    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final selectedMediaItem = useState<int?>(null);
    final focusedMediaItem = useValueNotifier<MediaItem?>(null);

    /// провайдер запросов к API KgCameras
    final kgCameraApi = ref.read(kgCameraApiProvider);

    /// список камер ЭлКат
    final kgCameraAsync = useMemoized(() => kgCameraApi.getElcatCameras());

    /// список камер SaimaNet
    final saimaAsync = useMemoized(() => kgCameraApi.getSaimaCameras());

    final categories = useMemoized(() => [
          CategoryListItem(
            title: 'ЭлКат',
            apiResponse: kgCameraAsync,
          ),
          CategoryListItem(
            title: 'Saima-Telecom',
            apiResponse: saimaAsync,
          ),
        ]);

    return VerticalListView(
      key: ValueKey(categories.length),
      padding: const EdgeInsets.symmetric(vertical: 28.0),
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          selectedMediaItem.value = null;
          focusedMediaItem.value = null;
        }
      },
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(
                  KrsTheme.safeArea.horizontal,
                  0.0,
                  KrsTheme.safeArea.horizontal,
                  20.0,
                ),
                child: Row(
                  children: [
                    if (category.onlineService.logo.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: OnlineServiceLogo(category.onlineService.logo),
                      ),
                    Text(
                      category.title,
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                )),
            SizedBox(
              height: MediaItemCard.height,
              child: HorizontalListView<MediaItem>(
                key: category.key,
                asyncItems: category.itemsFuture,
                itemBuilder: (context, item) {
                  return MediaItemCard(
                    mediaItem: item,
                    onFocusChange: (hasFocus) {},
                    onTap: () {
                      /// переходим на страницу деталей о сериале
                      context.pushNamed('player', extra: item);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
