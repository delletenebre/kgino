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
    idName: 'dbDb',
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
        name: 'isLiveStream',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'dbDb',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'viewed',
        type: IsarType.double,
      ),
      IsarPropertySchema(
        name: 'isSeen',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'hasShowNumbers',
        type: IsarType.bool,
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
  IsarCore.writeLong(writer, 5,
      object.updatedAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808);
  IsarCore.writeLong(writer, 6, object.position);
  IsarCore.writeLong(writer, 7, object.duration);
  IsarCore.writeBool(writer, 8, object.isLiveStream);
  IsarCore.writeString(writer, 9, object.dbDb);
  IsarCore.writeDouble(writer, 10, object.viewed);
  IsarCore.writeBool(writer, 11, object.isSeen);
  IsarCore.writeBool(writer, 12, object.hasShowNumbers);
  return Isar.fastHash(object.dbDb);
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
  final DateTime? _updatedAt;
  {
    final value = IsarCore.readLong(reader, 5);
    if (value == -9223372036854775808) {
      _updatedAt = null;
    } else {
      _updatedAt =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final int _position;
  {
    final value = IsarCore.readLong(reader, 6);
    if (value == -9223372036854775808) {
      _position = 0;
    } else {
      _position = value;
    }
  }
  final int _duration;
  {
    final value = IsarCore.readLong(reader, 7);
    if (value == -9223372036854775808) {
      _duration = 0;
    } else {
      _duration = value;
    }
  }
  final bool _isLiveStream;
  _isLiveStream = IsarCore.readBool(reader, 8);
  final object = MediaItemEpisode(
    id: _id,
    name: _name,
    seasonNumber: _seasonNumber,
    episodeNumber: _episodeNumber,
    updatedAt: _updatedAt,
    position: _position,
    duration: _duration,
    isLiveStream: _isLiveStream,
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
      {
        final value = IsarCore.readLong(reader, 5);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 6:
      {
        final value = IsarCore.readLong(reader, 6);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 7:
      {
        final value = IsarCore.readLong(reader, 7);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 8:
      return IsarCore.readBool(reader, 8);
    case 9:
      return IsarCore.readString(reader, 9) ?? '';
    case 10:
      return IsarCore.readDouble(reader, 10);
    case 11:
      return IsarCore.readBool(reader, 11);
    case 12:
      return IsarCore.readBool(reader, 12);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _MediaItemEpisodeUpdate {
  bool call({
    required String dbDb,
    String? id,
    String? name,
    int? seasonNumber,
    int? episodeNumber,
    DateTime? updatedAt,
    int? position,
    int? duration,
    bool? isLiveStream,
    double? viewed,
    bool? isSeen,
    bool? hasShowNumbers,
  });
}

class _MediaItemEpisodeUpdateImpl implements _MediaItemEpisodeUpdate {
  const _MediaItemEpisodeUpdateImpl(this.collection);

  final IsarCollection<String, MediaItemEpisode> collection;

  @override
  bool call({
    required String dbDb,
    Object? id = ignore,
    Object? name = ignore,
    Object? seasonNumber = ignore,
    Object? episodeNumber = ignore,
    Object? updatedAt = ignore,
    Object? position = ignore,
    Object? duration = ignore,
    Object? isLiveStream = ignore,
    Object? viewed = ignore,
    Object? isSeen = ignore,
    Object? hasShowNumbers = ignore,
  }) {
    return collection.updateProperties([
          dbDb
        ], {
          if (id != ignore) 1: id as String?,
          if (name != ignore) 2: name as String?,
          if (seasonNumber != ignore) 3: seasonNumber as int?,
          if (episodeNumber != ignore) 4: episodeNumber as int?,
          if (updatedAt != ignore) 5: updatedAt as DateTime?,
          if (position != ignore) 6: position as int?,
          if (duration != ignore) 7: duration as int?,
          if (isLiveStream != ignore) 8: isLiveStream as bool?,
          if (viewed != ignore) 10: viewed as double?,
          if (isSeen != ignore) 11: isSeen as bool?,
          if (hasShowNumbers != ignore) 12: hasShowNumbers as bool?,
        }) >
        0;
  }
}

sealed class _MediaItemEpisodeUpdateAll {
  int call({
    required List<String> dbDb,
    String? id,
    String? name,
    int? seasonNumber,
    int? episodeNumber,
    DateTime? updatedAt,
    int? position,
    int? duration,
    bool? isLiveStream,
    double? viewed,
    bool? isSeen,
    bool? hasShowNumbers,
  });
}

class _MediaItemEpisodeUpdateAllImpl implements _MediaItemEpisodeUpdateAll {
  const _MediaItemEpisodeUpdateAllImpl(this.collection);

  final IsarCollection<String, MediaItemEpisode> collection;

  @override
  int call({
    required List<String> dbDb,
    Object? id = ignore,
    Object? name = ignore,
    Object? seasonNumber = ignore,
    Object? episodeNumber = ignore,
    Object? updatedAt = ignore,
    Object? position = ignore,
    Object? duration = ignore,
    Object? isLiveStream = ignore,
    Object? viewed = ignore,
    Object? isSeen = ignore,
    Object? hasShowNumbers = ignore,
  }) {
    return collection.updateProperties(dbDb, {
      if (id != ignore) 1: id as String?,
      if (name != ignore) 2: name as String?,
      if (seasonNumber != ignore) 3: seasonNumber as int?,
      if (episodeNumber != ignore) 4: episodeNumber as int?,
      if (updatedAt != ignore) 5: updatedAt as DateTime?,
      if (position != ignore) 6: position as int?,
      if (duration != ignore) 7: duration as int?,
      if (isLiveStream != ignore) 8: isLiveStream as bool?,
      if (viewed != ignore) 10: viewed as double?,
      if (isSeen != ignore) 11: isSeen as bool?,
      if (hasShowNumbers != ignore) 12: hasShowNumbers as bool?,
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
    DateTime? updatedAt,
    int? position,
    int? duration,
    bool? isLiveStream,
    double? viewed,
    bool? isSeen,
    bool? hasShowNumbers,
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
    Object? updatedAt = ignore,
    Object? position = ignore,
    Object? duration = ignore,
    Object? isLiveStream = ignore,
    Object? viewed = ignore,
    Object? isSeen = ignore,
    Object? hasShowNumbers = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (id != ignore) 1: id as String?,
      if (name != ignore) 2: name as String?,
      if (seasonNumber != ignore) 3: seasonNumber as int?,
      if (episodeNumber != ignore) 4: episodeNumber as int?,
      if (updatedAt != ignore) 5: updatedAt as DateTime?,
      if (position != ignore) 6: position as int?,
      if (duration != ignore) 7: duration as int?,
      if (isLiveStream != ignore) 8: isLiveStream as bool?,
      if (viewed != ignore) 10: viewed as double?,
      if (isSeen != ignore) 11: isSeen as bool?,
      if (hasShowNumbers != ignore) 12: hasShowNumbers as bool?,
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
    Object? updatedAt = ignore,
    Object? position = ignore,
    Object? duration = ignore,
    Object? isLiveStream = ignore,
    Object? viewed = ignore,
    Object? isSeen = ignore,
    Object? hasShowNumbers = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (id != ignore) 1: id as String?,
        if (name != ignore) 2: name as String?,
        if (seasonNumber != ignore) 3: seasonNumber as int?,
        if (episodeNumber != ignore) 4: episodeNumber as int?,
        if (updatedAt != ignore) 5: updatedAt as DateTime?,
        if (position != ignore) 6: position as int?,
        if (duration != ignore) 7: duration as int?,
        if (isLiveStream != ignore) 8: isLiveStream as bool?,
        if (viewed != ignore) 10: viewed as double?,
        if (isSeen != ignore) 11: isSeen as bool?,
        if (hasShowNumbers != ignore) 12: hasShowNumbers as bool?,
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
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
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
          property: 5,
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
          property: 5,
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
          property: 5,
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
          property: 5,
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
          property: 5,
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
          property: 6,
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
          property: 6,
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
          property: 6,
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
          property: 6,
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
          property: 6,
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
          property: 6,
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
          property: 7,
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
          property: 7,
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
          property: 7,
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
          property: 7,
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
          property: 7,
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
          property: 7,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isLiveStreamEqualTo(
    bool value,
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
      dbDbEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 9,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      dbDbIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      viewedEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      viewedGreaterThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      viewedGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      viewedLessThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 10,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      viewedLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      viewedBetween(
    double lower,
    double upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      isSeenEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 11,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterFilterCondition>
      hasShowNumbersEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 12,
          value: value,
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
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByIsLiveStream() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByIsLiveStreamDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> sortByDbDb(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> sortByDbDbDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByViewed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByViewedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByIsSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByIsSeenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByHasShowNumbers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      sortByHasShowNumbersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
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
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByIsLiveStream() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByIsLiveStreamDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> thenByDbDb(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy> thenByDbDbDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByViewed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByViewedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByIsSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByIsSeenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByHasShowNumbers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterSortBy>
      thenByHasShowNumbersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
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
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByIsLiveStream() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByViewed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByIsSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11);
    });
  }

  QueryBuilder<MediaItemEpisode, MediaItemEpisode, QAfterDistinct>
      distinctByHasShowNumbers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
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

  QueryBuilder<MediaItemEpisode, DateTime?, QAfterProperty>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MediaItemEpisode, int, QAfterProperty> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MediaItemEpisode, int, QAfterProperty> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MediaItemEpisode, bool, QAfterProperty> isLiveStreamProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MediaItemEpisode, String, QAfterProperty> dbDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MediaItemEpisode, double, QAfterProperty> viewedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MediaItemEpisode, bool, QAfterProperty> isSeenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<MediaItemEpisode, bool, QAfterProperty>
      hasShowNumbersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
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

  QueryBuilder<MediaItemEpisode, (R, DateTime?), QAfterProperty>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, int), QAfterProperty> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, int), QAfterProperty> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, bool), QAfterProperty>
      isLiveStreamProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, String), QAfterProperty> dbDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, double), QAfterProperty> viewedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, bool), QAfterProperty> isSeenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<MediaItemEpisode, (R, bool), QAfterProperty>
      hasShowNumbersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
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

  QueryBuilder<MediaItemEpisode, (R1, R2, DateTime?), QOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, int), QOperations>
      positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, int), QOperations>
      durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, bool), QOperations>
      isLiveStreamProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, String), QOperations> dbDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, double), QOperations>
      viewedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, bool), QOperations> isSeenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<MediaItemEpisode, (R1, R2, bool), QOperations>
      hasShowNumbersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
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
      seasonNumber: (json['seasonNumber'] as num?)?.toInt() ?? 0,
      episodeNumber: (json['episodeNumber'] as num?)?.toInt() ?? 0,
      videoFileUrl: json['videoFileUrl'] as String? ?? '',
      qualities: (json['qualities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      subtitlesFileUrl: json['subtitlesFileUrl'] as String? ?? '',
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      position: (json['position'] as num?)?.toInt() ?? 0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      isLiveStream: json['isLiveStream'] as bool? ?? false,
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
      'isLiveStream': instance.isLiveStream,
    };
