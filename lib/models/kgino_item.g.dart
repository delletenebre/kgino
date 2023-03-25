// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kgino_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetKginoItemCollection on Isar {
  IsarCollection<KginoItem> get kginoItems => this.collection();
}

const KginoItemSchema = CollectionSchema(
  name: r'KginoItem',
  id: -3968783649370085008,
  properties: {
    r'episodeCount': PropertySchema(
      id: 0,
      name: r'episodeCount',
      type: IsarType.int,
    ),
    r'favorite': PropertySchema(
      id: 1,
      name: r'favorite',
      type: IsarType.dateTime,
    ),
    r'hasImdbRating': PropertySchema(
      id: 2,
      name: r'hasImdbRating',
      type: IsarType.bool,
    ),
    r'hasKinopoiskRating': PropertySchema(
      id: 3,
      name: r'hasKinopoiskRating',
      type: IsarType.bool,
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'posterUrl': PropertySchema(
      id: 6,
      name: r'posterUrl',
      type: IsarType.string,
    ),
    r'provider': PropertySchema(
      id: 7,
      name: r'provider',
      type: IsarType.string,
    ),
    r'storageKey': PropertySchema(
      id: 8,
      name: r'storageKey',
      type: IsarType.string,
    ),
    r'subtitlesEnabled': PropertySchema(
      id: 9,
      name: r'subtitlesEnabled',
      type: IsarType.bool,
    ),
    r'voiceActing': PropertySchema(
      id: 10,
      name: r'voiceActing',
      type: IsarType.string,
    )
  },
  estimateSize: _kginoItemEstimateSize,
  serialize: _kginoItemSerialize,
  deserialize: _kginoItemDeserialize,
  deserializeProp: _kginoItemDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {
    r'episodes': LinkSchema(
      id: 7002276521523555894,
      name: r'episodes',
      target: r'EpisodeItem',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _kginoItemGetId,
  getLinks: _kginoItemGetLinks,
  attach: _kginoItemAttach,
  version: '3.0.5',
);

int _kginoItemEstimateSize(
  KginoItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.posterUrl.length * 3;
  bytesCount += 3 + object.provider.length * 3;
  bytesCount += 3 + object.storageKey.length * 3;
  bytesCount += 3 + object.voiceActing.length * 3;
  return bytesCount;
}

void _kginoItemSerialize(
  KginoItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeInt(offsets[0], object.episodeCount);
  writer.writeDateTime(offsets[1], object.favorite);
  writer.writeBool(offsets[2], object.hasImdbRating);
  writer.writeBool(offsets[3], object.hasKinopoiskRating);
  writer.writeString(offsets[4], object.id);
  writer.writeString(offsets[5], object.name);
  writer.writeString(offsets[6], object.posterUrl);
  writer.writeString(offsets[7], object.provider);
  writer.writeString(offsets[8], object.storageKey);
  writer.writeBool(offsets[9], object.subtitlesEnabled);
  writer.writeString(offsets[10], object.voiceActing);
}

KginoItem _kginoItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = KginoItem(
    favorite: reader.readDateTimeOrNull(offsets[1]),
    id: reader.readString(offsets[4]),
    name: reader.readString(offsets[5]),
    posterUrl: reader.readString(offsets[6]),
    provider: reader.readString(offsets[7]),
    subtitlesEnabled: reader.readBoolOrNull(offsets[9]) ?? false,
    voiceActing: reader.readStringOrNull(offsets[10]) ?? '',
  );
  return object;
}

P _kginoItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readInt(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _kginoItemGetId(KginoItem object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _kginoItemGetLinks(KginoItem object) {
  return [object.episodes];
}

void _kginoItemAttach(IsarCollection<dynamic> col, Id id, KginoItem object) {
  object.episodes
      .attach(col, col.isar.collection<EpisodeItem>(), r'episodes', id);
}

extension KginoItemQueryWhereSort
    on QueryBuilder<KginoItem, KginoItem, QWhere> {
  QueryBuilder<KginoItem, KginoItem, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension KginoItemQueryWhere
    on QueryBuilder<KginoItem, KginoItem, QWhereClause> {
  QueryBuilder<KginoItem, KginoItem, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension KginoItemQueryFilter
    on QueryBuilder<KginoItem, KginoItem, QFilterCondition> {
  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> episodeCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodeCount',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      episodeCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'episodeCount',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      episodeCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'episodeCount',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> episodeCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'episodeCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> favoriteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'favorite',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      favoriteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'favorite',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> favoriteEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favorite',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> favoriteGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'favorite',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> favoriteLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'favorite',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> favoriteBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'favorite',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      hasImdbRatingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasImdbRating',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      hasKinopoiskRatingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasKinopoiskRating',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'posterUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      posterUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'posterUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'posterUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'posterUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'posterUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'posterUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'posterUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'posterUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'posterUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      posterUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'posterUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'provider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'provider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'provider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'provider',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'provider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'provider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'provider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'provider',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'provider',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      providerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'provider',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> storageKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storageKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      storageKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'storageKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> storageKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'storageKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> storageKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'storageKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      storageKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'storageKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> storageKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'storageKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> storageKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'storageKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> storageKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'storageKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      storageKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storageKey',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      storageKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'storageKey',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      subtitlesEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtitlesEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voiceActing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      voiceActingGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voiceActing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voiceActing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voiceActing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      voiceActingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'voiceActing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'voiceActing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'voiceActing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'voiceActing',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      voiceActingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voiceActing',
        value: '',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      voiceActingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'voiceActing',
        value: '',
      ));
    });
  }
}

extension KginoItemQueryObject
    on QueryBuilder<KginoItem, KginoItem, QFilterCondition> {}

extension KginoItemQueryLinks
    on QueryBuilder<KginoItem, KginoItem, QFilterCondition> {
  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> episodes(
      FilterQuery<EpisodeItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'episodes');
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      episodesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'episodes', length, true, length, true);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> episodesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'episodes', 0, true, 0, true);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      episodesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'episodes', 0, false, 999999, true);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      episodesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'episodes', 0, true, length, include);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      episodesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'episodes', length, include, 999999, true);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      episodesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'episodes', lower, includeLower, upper, includeUpper);
    });
  }
}

extension KginoItemQuerySortBy on QueryBuilder<KginoItem, KginoItem, QSortBy> {
  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByEpisodeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeCount', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByEpisodeCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeCount', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favorite', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favorite', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByHasImdbRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasImdbRating', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByHasImdbRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasImdbRating', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByHasKinopoiskRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasKinopoiskRating', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy>
      sortByHasKinopoiskRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasKinopoiskRating', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByPosterUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterUrl', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByPosterUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterUrl', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByProvider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'provider', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByProviderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'provider', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByStorageKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageKey', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByStorageKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageKey', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortBySubtitlesEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitlesEnabled', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy>
      sortBySubtitlesEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitlesEnabled', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByVoiceActing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voiceActing', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByVoiceActingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voiceActing', Sort.desc);
    });
  }
}

extension KginoItemQuerySortThenBy
    on QueryBuilder<KginoItem, KginoItem, QSortThenBy> {
  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByEpisodeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeCount', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByEpisodeCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeCount', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favorite', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favorite', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByHasImdbRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasImdbRating', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByHasImdbRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasImdbRating', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByHasKinopoiskRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasKinopoiskRating', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy>
      thenByHasKinopoiskRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasKinopoiskRating', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByPosterUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterUrl', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByPosterUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterUrl', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByProvider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'provider', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByProviderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'provider', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByStorageKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageKey', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByStorageKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageKey', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenBySubtitlesEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitlesEnabled', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy>
      thenBySubtitlesEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitlesEnabled', Sort.desc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByVoiceActing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voiceActing', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByVoiceActingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voiceActing', Sort.desc);
    });
  }
}

extension KginoItemQueryWhereDistinct
    on QueryBuilder<KginoItem, KginoItem, QDistinct> {
  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByEpisodeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'episodeCount');
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'favorite');
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByHasImdbRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasImdbRating');
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByHasKinopoiskRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasKinopoiskRating');
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByPosterUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'posterUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByProvider(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'provider', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByStorageKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'storageKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctBySubtitlesEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subtitlesEnabled');
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByVoiceActing(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voiceActing', caseSensitive: caseSensitive);
    });
  }
}

extension KginoItemQueryProperty
    on QueryBuilder<KginoItem, KginoItem, QQueryProperty> {
  QueryBuilder<KginoItem, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<KginoItem, int, QQueryOperations> episodeCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episodeCount');
    });
  }

  QueryBuilder<KginoItem, DateTime?, QQueryOperations> favoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'favorite');
    });
  }

  QueryBuilder<KginoItem, bool, QQueryOperations> hasImdbRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasImdbRating');
    });
  }

  QueryBuilder<KginoItem, bool, QQueryOperations> hasKinopoiskRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasKinopoiskRating');
    });
  }

  QueryBuilder<KginoItem, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<KginoItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<KginoItem, String, QQueryOperations> posterUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'posterUrl');
    });
  }

  QueryBuilder<KginoItem, String, QQueryOperations> providerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'provider');
    });
  }

  QueryBuilder<KginoItem, String, QQueryOperations> storageKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storageKey');
    });
  }

  QueryBuilder<KginoItem, bool, QQueryOperations> subtitlesEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subtitlesEnabled');
    });
  }

  QueryBuilder<KginoItem, String, QQueryOperations> voiceActingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voiceActing');
    });
  }
}
