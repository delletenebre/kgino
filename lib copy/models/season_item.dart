import 'package:freezed_annotation/freezed_annotation.dart';

import 'episode_item.dart';

part 'season_item.freezed.dart';

@unfreezed
class SeasonItem with _$SeasonItem {
  SeasonItem._();

  factory SeasonItem({
    /// название сезона
    @Default('') final String name,

    /// список эпизодов
    @Default([]) List<EpisodeItem> episodes,
    
  }) = _SeasonItem;
  
}
