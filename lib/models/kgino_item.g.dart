// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kgino_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetKginoItemCollection on Isar {
  IsarCollection<KginoItem> get kginoItems => getCollection();
}

const KginoItemSchema = CollectionSchema(
  name: 'KginoItem',
  schema:
      '{"name":"KginoItem","idName":"isarId","properties":[{"name":"bookmarked","type":"Long"},{"name":"episodeCount","type":"Long"},{"name":"id","type":"String"},{"name":"name","type":"String"},{"name":"playableQuality","type":"Long"},{"name":"posterUrl","type":"String"},{"name":"provider","type":"String"},{"name":"subtitlesEnabled","type":"Bool"},{"name":"voiceActing","type":"String"}],"indexes":[],"links":[{"name":"seenEpisodes","target":"EpisodeItem"}]}',
  idName: 'isarId',
  propertyIds: {
    'bookmarked': 0,
    'episodeCount': 1,
    'id': 2,
    'name': 3,
    'playableQuality': 4,
    'posterUrl': 5,
    'provider': 6,
    'subtitlesEnabled': 7,
    'voiceActing': 8
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {'seenEpisodes': 0},
  backlinkLinkNames: {},
  getId: _kginoItemGetId,
  setId: _kginoItemSetId,
  getLinks: _kginoItemGetLinks,
  attachLinks: _kginoItemAttachLinks,
  serializeNative: _kginoItemSerializeNative,
  deserializeNative: _kginoItemDeserializeNative,
  deserializePropNative: _kginoItemDeserializePropNative,
  serializeWeb: _kginoItemSerializeWeb,
  deserializeWeb: _kginoItemDeserializeWeb,
  deserializePropWeb: _kginoItemDeserializePropWeb,
  version: 3,
);

int? _kginoItemGetId(KginoItem object) {
  if (object.isarId == Isar.autoIncrement) {
    return null;
  } else {
    return object.isarId;
  }
}

void _kginoItemSetId(KginoItem object, int id) {
  object.isarId = id;
}

List<IsarLinkBase> _kginoItemGetLinks(KginoItem object) {
  return [object.seenEpisodes];
}

void _kginoItemSerializeNative(
    IsarCollection<KginoItem> collection,
    IsarRawObject rawObj,
    KginoItem object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.bookmarked;
  final _bookmarked = value0;
  final value1 = object.episodeCount;
  final _episodeCount = value1;
  final value2 = object.id;
  final _id = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_id.length) as int;
  final value3 = object.name;
  final _name = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_name.length) as int;
  final value4 = object.playableQuality;
  final _playableQuality = value4;
  final value5 = object.posterUrl;
  final _posterUrl = IsarBinaryWriter.utf8Encoder.convert(value5);
  dynamicSize += (_posterUrl.length) as int;
  final value6 = object.provider;
  final _provider = IsarBinaryWriter.utf8Encoder.convert(value6);
  dynamicSize += (_provider.length) as int;
  final value7 = object.subtitlesEnabled;
  final _subtitlesEnabled = value7;
  final value8 = object.voiceActing;
  final _voiceActing = IsarBinaryWriter.utf8Encoder.convert(value8);
  dynamicSize += (_voiceActing.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDateTime(offsets[0], _bookmarked);
  writer.writeLong(offsets[1], _episodeCount);
  writer.writeBytes(offsets[2], _id);
  writer.writeBytes(offsets[3], _name);
  writer.writeLong(offsets[4], _playableQuality);
  writer.writeBytes(offsets[5], _posterUrl);
  writer.writeBytes(offsets[6], _provider);
  writer.writeBool(offsets[7], _subtitlesEnabled);
  writer.writeBytes(offsets[8], _voiceActing);
}

KginoItem _kginoItemDeserializeNative(IsarCollection<KginoItem> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = KginoItem(
    bookmarked: reader.readDateTimeOrNull(offsets[0]),
    id: reader.readString(offsets[2]),
    name: reader.readString(offsets[3]),
    playableQuality: reader.readLong(offsets[4]),
    posterUrl: reader.readString(offsets[5]),
    provider: reader.readString(offsets[6]),
    subtitlesEnabled: reader.readBool(offsets[7]),
    voiceActing: reader.readString(offsets[8]),
  );
  object.isarId = id;
  _kginoItemAttachLinks(collection, id, object);
  return object;
}

P _kginoItemDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _kginoItemSerializeWeb(
    IsarCollection<KginoItem> collection, KginoItem object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(
      jsObj, 'bookmarked', object.bookmarked?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'episodeCount', object.episodeCount);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
  IsarNative.jsObjectSet(jsObj, 'name', object.name);
  IsarNative.jsObjectSet(jsObj, 'playableQuality', object.playableQuality);
  IsarNative.jsObjectSet(jsObj, 'posterUrl', object.posterUrl);
  IsarNative.jsObjectSet(jsObj, 'provider', object.provider);
  IsarNative.jsObjectSet(jsObj, 'subtitlesEnabled', object.subtitlesEnabled);
  IsarNative.jsObjectSet(jsObj, 'voiceActing', object.voiceActing);
  return jsObj;
}

KginoItem _kginoItemDeserializeWeb(
    IsarCollection<KginoItem> collection, dynamic jsObj) {
  final object = KginoItem(
    bookmarked: IsarNative.jsObjectGet(jsObj, 'bookmarked') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'bookmarked'),
                isUtc: true)
            .toLocal()
        : null,
    id: IsarNative.jsObjectGet(jsObj, 'id') ?? '',
    name: IsarNative.jsObjectGet(jsObj, 'name') ?? '',
    playableQuality: IsarNative.jsObjectGet(jsObj, 'playableQuality') ??
        double.negativeInfinity,
    posterUrl: IsarNative.jsObjectGet(jsObj, 'posterUrl') ?? '',
    provider: IsarNative.jsObjectGet(jsObj, 'provider') ?? '',
    subtitlesEnabled:
        IsarNative.jsObjectGet(jsObj, 'subtitlesEnabled') ?? false,
    voiceActing: IsarNative.jsObjectGet(jsObj, 'voiceActing') ?? '',
  );
  object.isarId = IsarNative.jsObjectGet(jsObj, 'isarId');
  _kginoItemAttachLinks(
      collection, IsarNative.jsObjectGet(jsObj, 'isarId'), object);
  return object;
}

P _kginoItemDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'bookmarked':
      return (IsarNative.jsObjectGet(jsObj, 'bookmarked') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'bookmarked'),
                  isUtc: true)
              .toLocal()
          : null) as P;
    case 'episodeCount':
      return (IsarNative.jsObjectGet(jsObj, 'episodeCount') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
    case 'isarId':
      return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
    case 'name':
      return (IsarNative.jsObjectGet(jsObj, 'name') ?? '') as P;
    case 'playableQuality':
      return (IsarNative.jsObjectGet(jsObj, 'playableQuality') ??
          double.negativeInfinity) as P;
    case 'posterUrl':
      return (IsarNative.jsObjectGet(jsObj, 'posterUrl') ?? '') as P;
    case 'provider':
      return (IsarNative.jsObjectGet(jsObj, 'provider') ?? '') as P;
    case 'subtitlesEnabled':
      return (IsarNative.jsObjectGet(jsObj, 'subtitlesEnabled') ?? false) as P;
    case 'voiceActing':
      return (IsarNative.jsObjectGet(jsObj, 'voiceActing') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _kginoItemAttachLinks(IsarCollection col, int id, KginoItem object) {
  object.seenEpisodes.attach(col, col.isar.episodeItems, 'seenEpisodes', id);
}

extension KginoItemQueryWhereSort
    on QueryBuilder<KginoItem, KginoItem, QWhere> {
  QueryBuilder<KginoItem, KginoItem, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension KginoItemQueryWhere
    on QueryBuilder<KginoItem, KginoItem, QWhereClause> {
  QueryBuilder<KginoItem, KginoItem, QAfterWhereClause> isarIdEqualTo(
      int isarId) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: isarId,
      includeLower: true,
      upper: isarId,
      includeUpper: true,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterWhereClause> isarIdNotEqualTo(
      int isarId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: isarId, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: isarId, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: isarId, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: isarId, includeUpper: false),
      );
    }
  }

  QueryBuilder<KginoItem, KginoItem, QAfterWhereClause> isarIdGreaterThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: isarId, includeLower: include),
    );
  }

  QueryBuilder<KginoItem, KginoItem, QAfterWhereClause> isarIdLessThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: isarId, includeUpper: include),
    );
  }

  QueryBuilder<KginoItem, KginoItem, QAfterWhereClause> isarIdBetween(
    int lowerIsarId,
    int upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerIsarId,
      includeLower: includeLower,
      upper: upperIsarId,
      includeUpper: includeUpper,
    ));
  }
}

extension KginoItemQueryFilter
    on QueryBuilder<KginoItem, KginoItem, QFilterCondition> {
  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> bookmarkedIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'bookmarked',
      value: null,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> bookmarkedEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'bookmarked',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      bookmarkedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'bookmarked',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> bookmarkedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'bookmarked',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> bookmarkedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'bookmarked',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> episodeCountEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'episodeCount',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      episodeCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'episodeCount',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      episodeCountLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'episodeCount',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> episodeCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'episodeCount',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> isarIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> isarIdEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> isarIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> isarIdLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> isarIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      playableQualityEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'playableQuality',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      playableQualityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'playableQuality',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      playableQualityLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'playableQuality',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      playableQualityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'playableQuality',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'posterUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      posterUrlGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'posterUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'posterUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'posterUrl',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'posterUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'posterUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'posterUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> posterUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'posterUrl',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'provider',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'provider',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'provider',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'provider',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'provider',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'provider',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'provider',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> providerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'provider',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      subtitlesEnabledEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'subtitlesEnabled',
      value: value,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'voiceActing',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      voiceActingGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'voiceActing',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'voiceActing',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'voiceActing',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition>
      voiceActingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'voiceActing',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'voiceActing',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'voiceActing',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> voiceActingMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'voiceActing',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension KginoItemQueryLinks
    on QueryBuilder<KginoItem, KginoItem, QFilterCondition> {
  QueryBuilder<KginoItem, KginoItem, QAfterFilterCondition> seenEpisodes(
      FilterQuery<EpisodeItem> q) {
    return linkInternal(
      isar.episodeItems,
      q,
      'seenEpisodes',
    );
  }
}

extension KginoItemQueryWhereSortBy
    on QueryBuilder<KginoItem, KginoItem, QSortBy> {
  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByBookmarked() {
    return addSortByInternal('bookmarked', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByBookmarkedDesc() {
    return addSortByInternal('bookmarked', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByEpisodeCount() {
    return addSortByInternal('episodeCount', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByEpisodeCountDesc() {
    return addSortByInternal('episodeCount', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByPlayableQuality() {
    return addSortByInternal('playableQuality', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByPlayableQualityDesc() {
    return addSortByInternal('playableQuality', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByPosterUrl() {
    return addSortByInternal('posterUrl', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByPosterUrlDesc() {
    return addSortByInternal('posterUrl', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByProvider() {
    return addSortByInternal('provider', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByProviderDesc() {
    return addSortByInternal('provider', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortBySubtitlesEnabled() {
    return addSortByInternal('subtitlesEnabled', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy>
      sortBySubtitlesEnabledDesc() {
    return addSortByInternal('subtitlesEnabled', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByVoiceActing() {
    return addSortByInternal('voiceActing', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> sortByVoiceActingDesc() {
    return addSortByInternal('voiceActing', Sort.desc);
  }
}

extension KginoItemQueryWhereSortThenBy
    on QueryBuilder<KginoItem, KginoItem, QSortThenBy> {
  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByBookmarked() {
    return addSortByInternal('bookmarked', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByBookmarkedDesc() {
    return addSortByInternal('bookmarked', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByEpisodeCount() {
    return addSortByInternal('episodeCount', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByEpisodeCountDesc() {
    return addSortByInternal('episodeCount', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByPlayableQuality() {
    return addSortByInternal('playableQuality', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByPlayableQualityDesc() {
    return addSortByInternal('playableQuality', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByPosterUrl() {
    return addSortByInternal('posterUrl', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByPosterUrlDesc() {
    return addSortByInternal('posterUrl', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByProvider() {
    return addSortByInternal('provider', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByProviderDesc() {
    return addSortByInternal('provider', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenBySubtitlesEnabled() {
    return addSortByInternal('subtitlesEnabled', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy>
      thenBySubtitlesEnabledDesc() {
    return addSortByInternal('subtitlesEnabled', Sort.desc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByVoiceActing() {
    return addSortByInternal('voiceActing', Sort.asc);
  }

  QueryBuilder<KginoItem, KginoItem, QAfterSortBy> thenByVoiceActingDesc() {
    return addSortByInternal('voiceActing', Sort.desc);
  }
}

extension KginoItemQueryWhereDistinct
    on QueryBuilder<KginoItem, KginoItem, QDistinct> {
  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByBookmarked() {
    return addDistinctByInternal('bookmarked');
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByEpisodeCount() {
    return addDistinctByInternal('episodeCount');
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByPlayableQuality() {
    return addDistinctByInternal('playableQuality');
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByPosterUrl(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('posterUrl', caseSensitive: caseSensitive);
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByProvider(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('provider', caseSensitive: caseSensitive);
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctBySubtitlesEnabled() {
    return addDistinctByInternal('subtitlesEnabled');
  }

  QueryBuilder<KginoItem, KginoItem, QDistinct> distinctByVoiceActing(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('voiceActing', caseSensitive: caseSensitive);
  }
}

extension KginoItemQueryProperty
    on QueryBuilder<KginoItem, KginoItem, QQueryProperty> {
  QueryBuilder<KginoItem, DateTime?, QQueryOperations> bookmarkedProperty() {
    return addPropertyNameInternal('bookmarked');
  }

  QueryBuilder<KginoItem, int, QQueryOperations> episodeCountProperty() {
    return addPropertyNameInternal('episodeCount');
  }

  QueryBuilder<KginoItem, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<KginoItem, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<KginoItem, String, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<KginoItem, int, QQueryOperations> playableQualityProperty() {
    return addPropertyNameInternal('playableQuality');
  }

  QueryBuilder<KginoItem, String, QQueryOperations> posterUrlProperty() {
    return addPropertyNameInternal('posterUrl');
  }

  QueryBuilder<KginoItem, String, QQueryOperations> providerProperty() {
    return addPropertyNameInternal('provider');
  }

  QueryBuilder<KginoItem, bool, QQueryOperations> subtitlesEnabledProperty() {
    return addPropertyNameInternal('subtitlesEnabled');
  }

  QueryBuilder<KginoItem, String, QQueryOperations> voiceActingProperty() {
    return addPropertyNameInternal('voiceActing');
  }
}
