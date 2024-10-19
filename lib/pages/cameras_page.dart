import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/kg_camera_api_provider.dart';
import '../models/category_list_item.dart';
import '../models/media_item.dart';
import '../resources/kika_theme.dart';

import '../ui/cards/media_item_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/online_service_list_title.dart';
import '../ui/lists/vertical_list_view.dart';

class CamerasPage extends HookConsumerWidget {
  const CamerasPage({super.key});

  @override
  Widget build(context, ref) {
    /// сохраняем состояние страницы между переходами [PageView]
    useAutomaticKeepAlive();

    /// провайдер запросов к API KgCameras
    final kgCameraApi = ref.read(kgCameraApiProvider);

    /// список камер ЭлКат
    final kgCameraAsync = useMemoized(() => kgCameraApi.getElcatCameras());

    /// список камер SaimaNet
    final saimaAsync = useMemoized(() => kgCameraApi.getSaimaCameras());

    /// список камер КыргызТелеком
    // final ktAsync = useMemoized(() => kgCameraApi.getKtCameras());

    /// список камер интересных мест
    final extraAsync = useMemoized(() => kgCameraApi.getExtraCameras());

    final categories = useMemoized(() => [
          CategoryListItem(
            title: 'ЭлКат',
            apiResponse: kgCameraAsync,
          ),
          CategoryListItem(
            title: 'Saima-Telecom',
            apiResponse: saimaAsync,
          ),
          // CategoryListItem(
          //   title: 'КыргызТелеком',
          //   apiResponse: ktAsync,
          // ),
          CategoryListItem(
            title: 'Интересное',
            items: extraAsync,
          ),
        ]);

    return Column(
      children: [
        const SizedBox(height: 56.0),
        Expanded(
          child: VerticalListView(
            itemHeight: kCardMaxHeight + kListTitleHeight,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return HorizontalListView<MediaItem>(
                // onMoveLeft: () {
                //   HomeLayout.maybeOf(context)?.openDrawer();
                // },
                title: OnlineServiceListTitle(category),
                asyncItems: category.itemsFuture,
                itemBuilder: (context, index, item) {
                  return MediaItemCard(
                    mediaItem: item,
                    onFocusChange: (hasFocus) {},
                    onPressed: () {
                      /// переходим к просмотру
                      context.pushNamed('player', extra: item);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
