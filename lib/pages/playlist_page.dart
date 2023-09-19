import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/filmix_api_provider.dart';
import '../models/test/media_item.dart';
import '../resources/constants.dart';
import '../ui/cards/featured_card.dart';
import '../ui/cards/media_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';

class PlaylistPage extends HookConsumerWidget {
  final MediaItem mediaItem;

  const PlaylistPage(
    this.mediaItem, {
    super.key,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: TvUi.navigationBarSize,
        child: SizedBox(
          height: TvUi.navigationBarSize.height,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TvUi.hPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 412.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mediaItem.title,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Expanded(
                    child: VerticalListView(
                      key: UniqueKey(),
                      keyEventResult: KeyEventResult.handled,
                      itemCount: mediaItem.seasons.length * 20,
                      itemBuilder: (context, index) {
                        //final season = mediaItem.seasons[index];
                        return ListTile(
                          onTap: () {},
                          title: Text('Season ${index}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: VerticalListView(
                key: UniqueKey(),
                keyEventResult: KeyEventResult.handled,
                itemCount: mediaItem.seasons.length * 20,
                itemBuilder: (context, index) {
                  //final season = mediaItem.seasons[index];
                  return ListTile(
                    onTap: () {},
                    title: Text('Episode ${index}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
