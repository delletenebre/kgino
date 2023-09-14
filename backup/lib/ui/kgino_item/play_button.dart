
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../resources/krs_locale.dart';
import '../../models/kgino_item.dart';

class PlayButton extends HookWidget {
  final KginoItem kginoItem;
  final String routeName;
  final void Function(bool)? onFocusChange;

  const PlayButton(this.kginoItem, {
    super.key,
    required this.routeName,
    this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    /// сохранённый в базе данных элемент
    final dbItemStream = useStream(kginoItem.dbStream,
      initialData: kginoItem,
    );

    if (dbItemStream.hasData && dbItemStream.data != null) {
      final dbItem = dbItemStream.data!;

      /// запрашиваем последний просмотренный эпизод
      final lastSeenEpisode = dbItem.getLastSeenEpisode();

      if (lastSeenEpisode != null) {
        /// ^ если у сериала есть просмотреные серии
        
        /// получаем эпизод, с которого нужно продолжить просмотр
        final playableEpisode = kginoItem.getNextPlayableEpisode(lastSeenEpisode);

        /// кнопка продолжить просмотр
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: FilledButton.tonalIcon(
            autofocus: true,
            onFocusChange: onFocusChange,
            onPressed: () {
              /// переходим на страницу плеера фильма
              context.pushNamed(routeName,
                pathParameters: {
                  'id': kginoItem.id,
                },
                queryParameters: {
                  'episodeId': playableEpisode.id,
                },
                extra: kginoItem,
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: Text(locale.play),
          ),
        );
      }
    }

    /// кнопка начала просмотра
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: FilledButton.tonalIcon(
        autofocus: true,
        onFocusChange: onFocusChange,
        onPressed: () {
          /// переходим на страницу плеера фильма
          context.pushNamed(routeName,
            pathParameters: {
              'id': kginoItem.id,
            },
            queryParameters: {
              'episodeId': kginoItem.seasons.first.episodes.first.id,
            },
            extra: kginoItem,
          );
        },
        icon: const Icon(Icons.play_arrow),
        label: Text(locale.play),
      ),
    );
    
  }
} 
