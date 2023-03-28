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
    r'bookmarked': PropertySchema(
      id: 0,
      name: r'bookmarked',
      type: IsarType.dateTime,
    ),
    r'episodeCount': PropertySchema(
      id: 1,
      name: r'episodeCount',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'posterUrl': PropertySchema(
      id: 4,
      name: r'posterUrl',
      type: IsarType.string,
    ),
    r'provider': PropertySchema(
      id: 5,
      name: r'provider',
      type: IsarType.string,
    ),
    r'subtitlesEnabled': PropertySchema(
      id: 6,
      name: r'subtitlesEnabled',
      type: IsarType.bool,
    ),
    r'voiceActing': PropertySchema(
      id: 7,
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
    r'seenEpisodes': LinkSchema(
      id: 6928117659106014040,
      name: r'seenEpisodes',
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
  bytesCount += 3 + object.voiceActing.length * 3;
  return bytesCount;
}

void _kginoItemSerialize(
  KginoItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.bookmarked);
  writer.writeLong(offsets[1], object.episodeCount);
  writer.writeString(offsets[2], object.id);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.posterUrl);
  writer.writeString(offsets[5], object.provider);
  writer.writeBool(offsets[6], object.subtitlesEnabled);
  writer.writeString(offsets[7], object.voiceActing);
}

KginoItem _kginoItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = KginoItem(
    bookmarked: reader.readDateTimeOrNull(offsets[0]),
    id: reader.readString(offsets[2]),
    name: reader.readString(offsets[3]),
    posterUrl: reader.readString(offsets[4]),
    provider: reader.readString(offsets[5]),
    subtitlesEnabled: reader.readBoolOrNull(offsets[6]) ?? false,
    voiceActing: reader.readStringOrNull(offsets[7]) ?? '',
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
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _kginoItemGetId(KginoItem object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _kginoItemGetLinks(KginoItem object) {
  return [object.seenEpisodes];
}

void _kginoItemAttach(IsarCollection<dynamic> col, Id id, KginoItem object) {
  object.seenEpisodes
      .attach(col, col.isar.collection<EpisodeItem>(), r'seenEpisodes', id);
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
  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> bookmarkedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bookmarked',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      bookmarkedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bookmarked',
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> bookmarkedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarked',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      bookmarkedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookmarked',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> bookmarkedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookmarked',
        value: value,
      ));
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> bookmarkedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookmarked',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

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
  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> seenEpisodes(
      FilterQuery<EpisodeItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'seenEpisodes');
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      seenEpisodesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'seenEpisodes', length, true, length, true);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      seenEpisodesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'seenEpisodes', 0, true, 0, true);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      seenEpisodesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'seenEpisodes', 0, false, 999999, true);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      seenEpisodesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'seenEpisodes', 0, true, length, include);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      seenEpisodesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'seenEpisodes', length, include, 999999, true);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      seenEpisodesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'seenEpisodes', lower, includeLower, upper, includeUpper);
    });
  }
}

extension KginoItemQuerySortBy on QueryBuilder<KginoItem, KginoItem, QSortBy> {
  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.desc);
    });
  }

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
  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.asc);
    });
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.desc);
    });
  }

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
  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookmarked');
    });
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByEpisodeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'episodeCount');
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

  QueryBuilder<KginoItem, DateTime?, QQueryOperations> bookmarkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarked');
    });
  }

  QueryBuilder<KginoItem, int, QQueryOperations> episodeCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episodeCount');
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
