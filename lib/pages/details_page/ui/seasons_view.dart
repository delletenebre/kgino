import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/media_item.dart';
import '../../../providers/locale_provider.dart';
import 'episode_card.dart';
import '../../../ui/lists/horizontal_list_view.dart';

class SeasonsView extends HookConsumerWidget {
  final MediaItem mediaItem;

  const SeasonsView(this.mediaItem, {super.key});

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = Locale.of(context);

    final episodes = useMemoized(() => mediaItem.episodes);

    final seasonsKey = useMemoized(() => GlobalKey<HorizontalListViewState>());
    final episodesKey = useMemoized(() => GlobalKey<HorizontalListViewState>());

    final selectedSeasonIndex = useValueNotifier(0);
    final selectedEpisodeIndex = useRef(0);

    /// необходим, когда со списка эпизодов переходим обратно на кнопки сезона,
    /// чтобы не прокручивало к первому эпизоду в сезоне
    final ignoreFocusUpdate = useRef(false);

    print('zzzzzzzzzz ${mediaItem.tmdb?.id}}');

    scrollEpisodesBySeason(int index) {
      if (ignoreFocusUpdate.value) {
        ignoreFocusUpdate.value = false;
        if (index != selectedSeasonIndex.value) {
          return;
        }
      }

      selectedSeasonIndex.value = index;

      final seasonIndex = selectedSeasonIndex.value;
      final season = mediaItem.seasons[seasonIndex];
      final minIndex = mediaItem.seasons
          .take(seasonIndex)
          .fold(0, (value, season) => value + season.episodes.length);

      /// максимальный индекс эпизода в нужном сезоне
      int maxIndex = minIndex + season.episodes.length;

      if (selectedEpisodeIndex.value < minIndex ||
          selectedEpisodeIndex.value >= maxIndex) {
        /// ^ если текущий выбранный эпизод не в выбранном сезоне

        /// прокручиваем список к первому эпизоду выбранного сезона
        episodesKey.currentState?.scrollTo(minIndex, requestFocus: false);

        /// обновляем индексы эпизода и сезона
        selectedSeasonIndex.value = seasonIndex;
        selectedEpisodeIndex.value = minIndex;
      } else {
        /// ^ если текущий выбранный эпизод из выбранного сезона

        /// обновляем индекс сезона
        selectedSeasonIndex.value = seasonIndex;
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HorizontalListView(
          key: seasonsKey,
          hasNavigationBar: false,
          padding: const EdgeInsets.symmetric(horizontal: 56.0),
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              ignoreFocusUpdate.value = true;
            }
          },
          onMoveLeft: () {
            /// индекс последнего сезона
            final lastSeasonIndex = mediaItem.seasons.length - 1;
            selectedSeasonIndex.value = lastSeasonIndex;

            seasonsKey.currentState?.scrollTo(lastSeasonIndex);

            /// прокручиваем к последнему сезону
            scrollEpisodesBySeason(lastSeasonIndex);
          },
          onMoveEnd: () {
            /// индекс последнего эпизода
            final lastEpisodeIndex = episodes.length - 1;
            episodesKey.currentState
                ?.scrollTo(lastEpisodeIndex, requestFocus: false);
            selectedEpisodeIndex.value = lastEpisodeIndex;
          },
          itemWidth: 86.0,
          itemHeight: 42.0,
          asyncItems: mediaItem.seasons,
          title: Text(locale.seasons),
          itemBuilder: (context, index, season) {
            return SizedBox(
              width: 86.0,
              child: ValueListenableBuilder(
                valueListenable: selectedSeasonIndex,
                builder: (context, value, _) => FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: (index == selectedSeasonIndex.value)
                        ? theme.colorScheme.inverseSurface
                        : null,
                    foregroundColor: (index == selectedSeasonIndex.value)
                        ? theme.colorScheme.onInverseSurface
                        : null,
                  ),
                  onFocusChange: (hasFocus) {
                    if (hasFocus) {
                      /// при выборе сезона перемещаем фокус на список эпизодов
                      scrollEpisodesBySeason(index);
                    }
                  },
                  onPressed: () {
                    /// прокручиваем эпизоды к выбранному сезону
                    scrollEpisodesBySeason(index);
                  },
                  child: Text('${index + 1}'),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20.0),
        HorizontalListView(
          key: episodesKey,
          hasNavigationBar: false,
          padding: const EdgeInsets.symmetric(horizontal: 56.0),
          asyncItems: episodes,
          title: Text(locale.episodes),
          itemBuilder: (context, index, episode) {
            return EpisodeCard(
              tmdbId: mediaItem.tmdb?.id,
              episode: episode,
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  final episodeIndex = index;
                  int episodesOffset = 0;

                  for (int i = 0; i < mediaItem.seasons.length; i++) {
                    /// текущий сезон
                    final season = mediaItem.seasons[i];

                    /// количество эпизодов в текущем сезоне
                    final episodesCount = season.episodes.length;

                    /// относительный индекс эпизода в нужном сезоне
                    final index = episodeIndex - episodesOffset;

                    if (episodesCount > index) {
                      /// обновляем индекс сезона

                      selectedSeasonIndex.value = i;

                      /// прокручиваем список сезонов к выбранному сезону
                      seasonsKey.currentState?.scrollTo(
                          selectedSeasonIndex.value,
                          requestFocus: false);

                      break;
                    }
                    episodesOffset += episodesCount;
                  }

                  /// обновляем индекс эпизода
                  selectedEpisodeIndex.value = episodeIndex;
                }
              },
              onPressed: (position) {
                /// переходим на страницу плеера
                context.pushNamed(
                  'player',
                  queryParameters: {
                    'episodeIndex': '$index',
                    'initialPosition': '$position',
                  },
                  extra: mediaItem,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
