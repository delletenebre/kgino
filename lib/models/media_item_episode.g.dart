// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item_episode.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetMediaItemEpisodeCollection on Isar {
  IsarCollection<String, MediaItemEpisode> get mediaItemEpisodes =>
      this.collection();
}

const MediaItemEpisodeSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'MediaItemEpisode',
    idName: 'isarDb',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'seasonNumber',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'episodeNumber',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'videoFileUrl',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'subtitlesFileUrl',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'qualities',
        type: IsarType.longList,
      ),
      IsarPropertySchema(
        name: 'updatedAt',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'position',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'duration',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'isarDb',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, MediaItemEpisode>(
    serialize: serializeMediaItemEpisode,
    deserialize: deserializeMediaItemEpisode,
    deserializeProperty: deserializeMediaItemEpisodeProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeMediaItemEpisode(IsarWriter writer, MediaItemEpisode object) {
  IsarCore.writeString(writer, 1, object.id);
  IsarCore.writeString(writer, 2, object.name);
  IsarCore.writeLong(writer, 3, object.seasonNumber);
  IsarCore.writeLong(writer, 4, object.episodeNumber);
  IsarCore.writeString(writer, 5, object.videoFileUrl);
  IsarCore.writeString(writer, 6, object.subtitlesFileUrl);
  {
    final list = object.qualities;
    final listWriter = IsarCore.beginList(writer, 7, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeLong(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  IsarCore.writeLong(writer, 8,
      object.updatedAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808);
  IsarCore.writeLong(writer, 9, object.position);
  IsarCore.writeLong(writer, 10, object.duration);
  IsarCore.writeString(writer, 11, object.isarDb);
  return Isar.fastHash(object.isarDb);
}

@isarProtected
MediaItemEpisode deserializeMediaItemEpisode(IsarReader reader) {
  final String _id;
  _id = IsarCore.readString(reader, 1) ?? '';
  final String _name;
  _name = IsarCore.readString(reader, 2) ?? '';
  final int _seasonNumber;
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      _seasonNumber = 0;
    } else {
      _seasonNumber = value;
    }
  }
  final int _episodeNumber;
  {
    final value = IsarCore.readLong(reader, 4);
    if (value == -9223372036854775808) {
      _episodeNumber = 0;
    } else {
      _episodeNumber = value;
    }
  }
  final String _videoFileUrl;
  _videoFileUrl = IsarCore.readString(reader, 5) ?? '';
  final String _subtitlesFileUrl;
  _subtitlesFileUrl = IsarCore.readString(reader, 6) ?? '';
  final List<int> _qualities;
  {
    final length = IsarCore.readList(reader, 7, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _qualities = const [];
      } else {
        final list =
            List<int>.filled(length, -9223372036854775808, growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readLong(reader, i);
        }
        IsarCore.freeReader(reader);
        _qualities = list;
      }
    }
  }
  final DateTime? _updatedAt;
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      _updatedAt = null;
    } else {
      _updatedAt =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final int _position;
  {
    final value = IsarCore.readLong(reader, 9);
    if (value == -9223372036854775808) {
      _position = 0;
    } else {
      _position = value;
    }
  }
  final int _duration;
  {
    final value = IsarCore.readLong(reader, 10);
    if (value == -9223372036854775808) {
      _duration = 0;
    } else {
      _duration = value;
    }
  }
  final object = MediaItemEpisode(
    id: _id,
    name: _name,
    seasonNumber: _seasonNumber,
    episodeNumber: _episodeNumber,
    videoFileUrl: _videoFileUrl,
    subtitlesFileUrl: _subtitlesFileUrl,
    qualities: _qualities,
    updatedAt: _updatedAt,
    position: _position,
    duration: _duration,
  );
  return object;
}

@isarProtected
dynamic deserializeMediaItemEpisodeProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      {
        final value = IsarCore.readLong(reader, 3);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 4:
      {
        final value = IsarCore.readLong(reader, 4);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      return IsarCore.readString(reader, 6) ?? '';
    case 7:
      {
        final length = IsarCore.readList(reader, 7, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const [];
          } else {
            final list =
                List<int>.filled(length, -9223372036854775808, growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readLong(reader, i);
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 8:
      {
        final value = IsarCore.readLong(reader, 8);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 9:
      {
        final value = IsarCore.readLong(reader, 9);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 10:
      {
        final value = IsarCore.readLong(reader, 10);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 11:
      return IsarCore.readString(reader, 11) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _MediaItemEpisodeUpdate {
  bool call({
    required String isarDb,
    String? id,
    String? name,
    int? seasonNumber,
    int? episodeNumber,
    String? videoFileUrl,
    String? subtitlesFileUrl,
    DateTime? updatedAt,
    int? position,
    int? duration,
  });
}

class _MediaItemEpisodeUpdateImpl implements _MediaItemEpisodeUpdate {
  const _MediaItemEpisodeUpdateImpl(this.collection);

  final IsarCollection<String, MediaItemEpisode> collection;

  @override
  bool call({
    required String isarDb,
    Object? id = ignore,
    Object? name = ignore,
    Object? seasonNumber = ignore,
    Object? episodeNumber = ignore,
    Object? videoFileUrl = ignore,
    Object? subtitlesFileUrl = ignore,
    Object? updatedAt = ignore,
    Object? position = ignore,
    Object? duration = ignore,
  }) {
    return collection.updateProperties([
          isarDb
        ], {
          if (id != ignore) 1: id as String?,
          if (name != ignore) 2: name as String?,
          if (seasonNumber != ignore) 3: seasonNumber as int?,
          if (episodeNumber != ignore) 4: episodeNumber as int?,
          if (videoFileUrl != ignore) 5: videoFileUrl as String?,
          if (subtitlesFileUrl != ignore) 6: subtitlesFileUrl as String?,
          if (updatedAt != ignore) 8: updatedAt as DateTime?,
          if (position != ignore) 9: position as int?,
          if (duration != ignore) 10: duration as int?,
        }) >
        0;
  }
}

sealed class _MediaItemEpisodeUpdateAll {
  int call({
    required List<String> isarDb,
    String? id,
    String? name,
    int? seasonNumber,
    int? episodeNumber,
    String? videoFileUrl,
    String? subtitlesFileUrl,
    DateTime? updatedAt,
    int? position,
    int? duration,
  });
}

class _MediaItemEpisodeUpdateAllImpl implements _MediaItemEpisodeUpdateAll {
  const _MediaItemEpisodeUpdateAllImpl(this.collection);

  final IsarCollection<String, MediaItemEpisode> collection;

  @override
  int call({
    required List<String> isarDb,
    Object? id = ignore,
    Object? name = ignore,
    Object? seasonNumber = ignore,
    Object? episodeNumber = ignore,
    Object? videoFileUrl = ignore,
    Object? subtitlesFileUrl = ignore,
    Object? updatedAt = ignore,
    Object? position = ignore,
    Object? duration = ignore,
  }) {
    return collection.updateProperties(isarDb, {
      if (id != ignore) 1: id as String?,
      if (name != ignore) 2: name as String?,
      if (seasonNumber != ignore) 3: seasonNumber as int?,
      if (episodeNumber != ignore) 4: episodeNumber as int?,
      if (videoFileUrl != ignore) 5: videoFileUrl as String?,
      if (subtitlesFileUrl != ignore) 6: subtitlesFileUrl as String?,
      if (updatedAt != ignore) 8: updatedAt as DateTime?,
      if (position != ignore) 9: position as int?,
      if (duration != ignore) 10: duration as int?,
    });
  }
}

extension MediaItemEpisodeUpdate on IsarCollection<String, MediaItemEpisode> {
  _MediaItemEpisodeUpdate get update => _MediaItemEpisodeUpdateImpl(this);

  _MediaItemEpisodeUpdateAll get updateAll =>
      _MediaItemEpisodeUpdateAllImpl(this);
}

sealed class _MediaItemEpisodeQueryUpdate {
  int call({
    String? id,
    String? name,
    int? seasonNumber,
    int? episodeNumber,
    String? videoFileUrl,
    String? subtitlesFileUrl,
    DateTime? updatedAt,
    int? position,
    int? duration,
  });
}

class _MediaItemEpisodeQueryUpdateImpl implements _MediaItemEpisodeQueryUpdate {
  const _MediaItemEpisodeQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<MediaItemEpisode> query;
  final int? limit;

  @override
  int call({
    Object? id = ignore,
    Object? name = ignore,
    Object? seasonNumber = ignore,
    Object? episodeNumber = ignore,
    Object? videoFileUrl = ignore,
    Object? subtitlesFileUrl = ignore,
    Object? updatedAt = ignore,
    Object? position = ignore,
    Object? duration = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (id != ignore) 1: id as String?,
      if (name != ignore) 2: name as String?,
      if (seasonNumber != ignore) 3: seasonNumber as int?,
      if (episodeNumber != ignore) 4: episodeNumber as int?,
      if (videoFileUrl != ignore) 5: videoFileUrl as String?,
      if (subtitlesFileUrl != ignore) 6: subtitlesFileUrl as String?,
      if (updatedAt != ignore) 8: updatedAt as DateTime?,
      if (position != ignore) 9: position as int?,
      if (duration != ignore) 10: duration as int?,
    });
  }
}

extension MediaItemEpisodeQueryUpdate on IsarQuery<MediaItemEpisode> {
  _MediaItemEpisodeQueryUpdate get updateFirst =>
      _MediaItemEpisodeQueryUpdateImpl(this, limit: 1);

  _MediaItemEpisodeQueryUpdate get updateAll =>
      _MediaItemEpisodeQueryUpdateImpl(this);
}

class _MediaItemEpisodeQueryBuilderUpdateImpl
    implements _MediaItemEpisodeQueryUpdate {
  const _MediaItemEpisodeQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<MediaItemEpisode, MediaItemEpisode, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? id = ignore,
    Object? name = ignore,
    Object? seasonNumber = ignore,
    Object? episodeNumber = ignore,
    Object? videoFileUrl = ignore,
    Object? subtitlesFileUrl = ignore,
    Object? updatedAt = ignore,
    Object? position = ignore,
    Object? duration = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (id != ignore) 1: id as String?,
        if (name != ignore) 2: name as String?,
        if (seasonNumber != ignore) 3: seasonNumber as int?,
        if (episodeNumber != ignore) 4: episodeNumber as int?,
        if (videoFileUrl != ignore) 5: videoFileUrl as String?,
        if (subtitlesFileUrl != ignore) 6: subtitlesFileUrl as String?,
        if (updatedAt != ignore) 8: updatedAt as DateTime?,
        if (position != ignore) 9: position as int?,
        if (duration != ignore) 10: duration as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension MediaItemEpisodeQueryBuilderUpdate
    on QueryBuilder<MediaItemEpisode, MediaItemEpisode, QOperations> {
  _MediaItemEpisodeQueryUpdate get updateFirst =>
      _MediaItemEpisodeQueryBuilderUpdateImpl(this, limit: 1);

  _MediaItemEpisodeQueryUpdate get updateAll =>
      _MediaItemEpisodeQueryBuilderUpdateImpl(this);
}

extension MediaItemEpisodeQueryFilter
    on QueryBuilder<MediaItemEpisode, MediaItemEpisode, QFilterCondition> {
  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      seasonNumberEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      seasonNumberGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      seasonNumberGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      seasonNumberLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      seasonNumberLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      seasonNumberBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      episodeNumberEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      episodeNumberGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      episodeNumberGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      episodeNumberLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      episodeNumberLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      episodeNumberBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 5,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      videoFileUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 6,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      subtitlesFileUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      qualitiesElementEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      qualitiesElementGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      qualitiesElementGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      qualitiesElementLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      qualitiesElementLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      qualitiesElementBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      qualitiesIsEmpty() {
    return not().qualitiesIsNotEmpty();
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      qualitiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 7, value: null),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      updatedAtGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      updatedAtLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 8,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      positionEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      positionGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      positionGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      positionLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      positionLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      positionBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      durationEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      durationGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      durationGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      durationLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      durationLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      durationBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 11,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 11,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isarDbIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }
}

extension MediaItemEpisodeQueryObject
    on QueryBuilder<MediaItemEpisode, MediaItemEpisode, QFilterCondition> {}

extension MediaItemEpisodeQuerySortBy
    on QueryBuilder<MediaItemEpisode, MediaItemEpisode, QSortBy> {
  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> sortByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortBySeasonNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortBySeasonNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByEpisodeNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByEpisodeNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByVideoFileUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByVideoFileUrlDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortBySubtitlesFileUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortBySubtitlesFileUrlDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> sortByIsarDb(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByIsarDbDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension MediaItemEpisodeQuerySortThenBy
    on QueryBuilder<MediaItemEpisode, MediaItemEpisode, QSortThenBy> {
  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenBySeasonNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenBySeasonNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByEpisodeNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByEpisodeNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByVideoFileUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByVideoFileUrlDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenBySubtitlesFileUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenBySubtitlesFileUrlDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> thenByIsarDb(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByIsarDbDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension MediaItemEpisodeQueryWhereDistinct
    on QueryBuilder<MediaItemEpisode, MediaItemEpisode, QDistinct> {
  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctBySeasonNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByEpisodeNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByVideoFileUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctBySubtitlesFileUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByQualities() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }
}

extension MediaItemEpisodeQueryProperty1
    on QueryBuilder<MediaItemEpisode, MediaItemEpisode, QProperty> {
  QueryBuilder<MediaItemEpisode, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MediaItemEpisode, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MediaItemEpisode, int, QAfterProperty> seasonNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MediaItemEpisode, int, QAfterProperty> episodeNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MediaItemEpisode, String, QAfterProperty>
      videoFileUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MediaItemEpisode, String, QAfterProperty>
      subtitlesFileUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MediaItemEpisode, List<int>, QAfterProperty>
      qualitiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MediaItemEpisode, DateTime?, QAfterProperty>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MediaItemEpisode, int, QAfterProperty> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MediaItemEpisode, int, QAfterProperty> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MediaItemEpisode, String, QAfterProperty> isarDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

extension MediaItemEpisodeQueryProperty2<R>
    on QueryBuilder<MediaItemEpisode, R, QAfterProperty> {
  QueryBuilder<MediaItemEpisode, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, String), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, int), QAfterProperty>
      seasonNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, int), QAfterProperty>
      episodeNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, String), QAfterProperty>
      videoFileUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, String), QAfterProperty>
      subtitlesFileUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, List<int>), QAfterProperty>
      qualitiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, DateTime?), QAfterProperty>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, int), QAfterProperty> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, int), QAfterProperty> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, String), QAfterProperty> isarDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

extension MediaItemEpisodeQueryProperty3<R1, R2>
    on QueryBuilder<MediaItemEpisode, (R1, R2), QAfterProperty> {
  QueryBuilder<MediaItemEpisode, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, String), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, int), QOperations>
      seasonNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, int), QOperations>
      episodeNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, String), QOperations>
      videoFileUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, String), QOperations>
      subtitlesFileUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, List<int>), QOperations>
      qualitiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, DateTime?), QOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, int), QOperations>
      positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, int), QOperations>
      durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, String), QOperations>
      isarDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaItemEpisode _$MediaItemEpisodeFromJson(Map<String, dynamic> json) =>
    MediaItemEpisode(
      id: json['id'] == null
          ? ''
          : const StringConverter().fromJson(json['id']),
      name: json['name'] as String? ?? '',
      seasonNumber: json['seasonNumber'] as int? ?? 0,
      episodeNumber: json['episodeNumber'] as int? ?? 0,
      videoFileUrl: json['videoFileUrl'] as String? ?? '',
      qualities: (json['qualities'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      subtitlesFileUrl: json['subtitlesFileUrl'] as String? ?? '',
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      position: json['position'] as int? ?? 0,
      duration: json['duration'] as int? ?? 0,
    );

Map<String, dynamic> _$MediaItemEpisodeToJson(MediaItemEpisode instance) =>
    <String, dynamic>{
      'id': const StringConverter().toJson(instance.id),
      'name': instance.name,
      'seasonNumber': instance.seasonNumber,
      'episodeNumber': instance.episodeNumber,
      'videoFileUrl': instance.videoFileUrl,
      'subtitlesFileUrl': instance.subtitlesFileUrl,
      'qualities': instance.qualities,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'position': instance.position,
      'duration': instance.duration,
    };