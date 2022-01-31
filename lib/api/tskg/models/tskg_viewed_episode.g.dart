// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_viewed_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TskgViewedEpisode _$TskgViewedEpisodeFromJson(Map<String, dynamic> json) =>
    TskgViewedEpisode(
      showId: json['showId'] as String,
      episodeId: json['episodeId'] as int,
      position: json['position'] as int,
      viewTimestamp: json['viewTimestamp'] as int,
    );

Map<String, dynamic> _$TskgViewedEpisodeToJson(TskgViewedEpisode instance) =>
    <String, dynamic>{
      'showId': instance.showId,
      'episodeId': instance.episodeId,
      'position': instance.position,
      'viewTimestamp': instance.viewTimestamp,
    };
