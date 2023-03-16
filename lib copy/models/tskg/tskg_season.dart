import 'package:freezed_annotation/freezed_annotation.dart';

import 'tskg_episode.dart';

part 'tskg_season.freezed.dart';

@freezed
class TskgSeason with _$TskgSeason {
  const factory TskgSeason({
    @Default('') String title,
    @Default([]) List<TskgEpisode> episodes,
  }) = _TskgSeason;
}
