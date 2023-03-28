// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flmx_player_links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FlmxPlayerLinks _$$_FlmxPlayerLinksFromJson(Map<String, dynamic> json) =>
    _$_FlmxPlayerLinks(
      movie: (json['movie'] as List<dynamic>?)
              ?.map((e) => FlmxMovieLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      playlist: (json['playlist'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k,
                (e as Map<String, dynamic>).map(
                  (k, e) => MapEntry(
                      k,
                      (e as Map<String, dynamic>).map(
                        (k, e) => MapEntry(k,
                            FlmxShowLink.fromJson(e as Map<String, dynamic>)),
                      )),
                )),
          ) ??
          const {},
    );

Map<String, dynamic> _$$_FlmxPlayerLinksToJson(_$_FlmxPlayerLinks instance) =>
    <String, dynamic>{
      'movie': instance.movie,
      'playlist': instance.playlist,
    };
