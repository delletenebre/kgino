// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetEpisodeItemCollection on Isar {
  IsarCollection<EpisodeItem> get episodeItems => getCollection();
}

const EpisodeItemSchema = CollectionSchema(
  name: 'EpisodeItem',
  schema:
      '{"name":"EpisodeItem","idName":"isarId","properties":[{"name":"duration","type":"Long"},{"name":"episodeNumber","type":"Long"},{"name":"fullId","type":"String"},{"name":"id","type":"String"},{"name":"name","type":"String"},{"name":"playableQualities","type":"LongList"},{"name":"position","type":"Long"},{"name":"seasonNumber","type":"Long"},{"name":"subtitlesFileUrl","type":"String"},{"name":"updatedAt","type":"Long"},{"name":"videoFileUrl","type":"String"}],"indexes":[],"links":[]}',
  idName: 'isarId',
  propertyIds: {
    'duration': 0,
    'episodeNumber': 1,
    'fullId': 2,
    'id': 3,
    'name': 4,
    'playableQualities': 5,
    'position': 6,
    'seasonNumber': 7,
    'subtitlesFileUrl': 8,
    'updatedAt': 9,
    'videoFileUrl': 10
  },
  listProperties: {'playableQualities'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _episodeItemGetId,
  setId: _episodeItemSetId,
  getLinks: _episodeItemGetLinks,
  attachLinks: _episodeItemAttachLinks,
  serializeNative: _episodeItemSerializeNative,
  deserializeNative: _episodeItemDeserializeNative,
  deserializePropNative: _episodeItemDeserializePropNative,
  serializeWeb: _episodeItemSerializeWeb,
  deserializeWeb: _episodeItemDeserializeWeb,
  deserializePropWeb: _episodeItemDeserializePropWeb,
  version: 3,
);

int? _episodeItemGetId(EpisodeItem object) {
  if (object.isarId == Isar.autoIncrement) {
    return null;
  } else {
    return object.isarId;
  }
}

void _episodeItemSetId(EpisodeItem object, int id) {
  object.isarId = id;
}

List<IsarLinkBase> _episodeItemGetLinks(EpisodeItem object) {
  return [];
}

void _episodeItemSerializeNative(
    IsarCollection<EpisodeItem> collection,
    IsarRawObject rawObj,
    EpisodeItem object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.duration;
  final _duration = value0;
  final value1 = object.episodeNumber;
  final _episodeNumber = value1;
  final value2 = object.fullId;
  final _fullId = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_fullId.length) as int;
  final value3 = object.id;
  final _id = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_id.length) as int;
  final value4 = object.name;
  final _name = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_name.length) as int;
  final value5 = object.playableQualities;
  dynamicSize += (value5.length) * 8;
  final _playableQualities = value5;
  final value6 = object.position;
  final _position = value6;
  final value7 = object.seasonNumber;
  final _seasonNumber = value7;
  final value8 = object.subtitlesFileUrl;
  final _subtitlesFileUrl = IsarBinaryWriter.utf8Encoder.convert(value8);
  dynamicSize += (_subtitlesFileUrl.length) as int;
  final value9 = object.updatedAt;
  final _updatedAt = value9;
  final value10 = object.videoFileUrl;
  final _videoFileUrl = IsarBinaryWriter.utf8Encoder.convert(value10);
  dynamicSize += (_videoFileUrl.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _duration);
  writer.writeLong(offsets[1], _episodeNumber);
  writer.writeBytes(offsets[2], _fullId);
  writer.writeBytes(offsets[3], _id);
  writer.writeBytes(offsets[4], _name);
  writer.writeLongList(offsets[5], _playableQualities);
  writer.writeLong(offsets[6], _position);
  writer.writeLong(offsets[7], _seasonNumber);
  writer.writeBytes(offsets[8], _subtitlesFileUrl);
  writer.writeDateTime(offsets[9], _updatedAt);
  writer.writeBytes(offsets[10], _videoFileUrl);
}

EpisodeItem _episodeItemDeserializeNative(
    IsarCollection<EpisodeItem> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = EpisodeItem(
    duration: reader.readLong(offsets[0]),
    episodeNumber: reader.readLong(offsets[1]),
    fullId: reader.readString(offsets[2]),
    id: reader.readString(offsets[3]),
    name: reader.readString(offsets[4]),
    playableQualities: reader.readLongList(offsets[5]) ?? [],
    position: reader.readLong(offsets[6]),
    seasonNumber: reader.readLong(offsets[7]),
    subtitlesFileUrl: reader.readString(offsets[8]),
    updatedAt: reader.readDateTimeOrNull(offsets[9]),
    videoFileUrl: reader.readString(offsets[10]),
  );
  object.isarId = id;
  return object;
}

P _episodeItemDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLongList(offset) ?? []) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _episodeItemSerializeWeb(
    IsarCollection<EpisodeItem> collection, EpisodeItem object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'duration', object.duration);
  IsarNative.jsObjectSet(jsObj, 'episodeNumber', object.episodeNumber);
  IsarNative.jsObjectSet(jsObj, 'fullId', object.fullId);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
  IsarNative.jsObjectSet(jsObj, 'name', object.name);
  IsarNative.jsObjectSet(jsObj, 'playableQualities', object.playableQualities);
  IsarNative.jsObjectSet(jsObj, 'position', object.position);
  IsarNative.jsObjectSet(jsObj, 'seasonNumber', object.seasonNumber);
  IsarNative.jsObjectSet(jsObj, 'subtitlesFileUrl', object.subtitlesFileUrl);
  IsarNative.jsObjectSet(
      jsObj, 'updatedAt', object.updatedAt?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'videoFileUrl', object.videoFileUrl);
  return jsObj;
}

EpisodeItem _episodeItemDeserializeWeb(
    IsarCollection<EpisodeItem> collection, dynamic jsObj) {
  final object = EpisodeItem(
    duration:
        IsarNative.jsObjectGet(jsObj, 'duration') ?? double.negativeInfinity,
    episodeNumber: IsarNative.jsObjectGet(jsObj, 'episodeNumber') ??
        double.negativeInfinity,
    fullId: IsarNative.jsObjectGet(jsObj, 'fullId') ?? '',
    id: IsarNative.jsObjectGet(jsObj, 'id') ?? '',
    name: IsarNative.jsObjectGet(jsObj, 'name') ?? '',
    playableQualities:
        (IsarNative.jsObjectGet(jsObj, 'playableQualities') as List?)
                ?.map((e) => e ?? double.negativeInfinity)
                .toList()
                .cast<int>() ??
            [],
    position:
        IsarNative.jsObjectGet(jsObj, 'position') ?? double.negativeInfinity,
    seasonNumber: IsarNative.jsObjectGet(jsObj, 'seasonNumber') ??
        double.negativeInfinity,
    subtitlesFileUrl: IsarNative.jsObjectGet(jsObj, 'subtitlesFileUrl') ?? '',
    updatedAt: IsarNative.jsObjectGet(jsObj, 'updatedAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'updatedAt'),
                isUtc: true)
            .toLocal()
        : null,
    videoFileUrl: IsarNative.jsObjectGet(jsObj, 'videoFileUrl') ?? '',
  );
  object.isarId = IsarNative.jsObjectGet(jsObj, 'isarId');
  return object;
}

P _episodeItemDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'duration':
      return (IsarNative.jsObjectGet(jsObj, 'duration') ??
          double.negativeInfinity) as P;
    case 'episodeNumber':
      return (IsarNative.jsObjectGet(jsObj, 'episodeNumber') ??
          double.negativeInfinity) as P;
    case 'fullId':
      return (IsarNative.jsObjectGet(jsObj, 'fullId') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
    case 'isarId':
      return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
    case 'name':
      return (IsarNative.jsObjectGet(jsObj, 'name') ?? '') as P;
    case 'playableQualities':
      return ((IsarNative.jsObjectGet(jsObj, 'playableQualities') as List?)
              ?.map((e) => e ?? double.negativeInfinity)
              .toList()
              .cast<int>() ??
          []) as P;
    case 'position':
      return (IsarNative.jsObjectGet(jsObj, 'position') ??
          double.negativeInfinity) as P;
    case 'seasonNumber':
      return (IsarNative.jsObjectGet(jsObj, 'seasonNumber') ??
          double.negativeInfinity) as P;
    case 'subtitlesFileUrl':
      return (IsarNative.jsObjectGet(jsObj, 'subtitlesFileUrl') ?? '') as P;
    case 'updatedAt':
      return (IsarNative.jsObjectGet(jsObj, 'updatedAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'updatedAt'),
                  isUtc: true)
              .toLocal()
          : null) as P;
    case 'videoFileUrl':
      return (IsarNative.jsObjectGet(jsObj, 'videoFileUrl') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _episodeItemAttachLinks(IsarCollection col, int id, EpisodeItem object) {}

extension EpisodeItemQueryWhereSort
    on QueryBuilder<EpisodeItem, EpisodeItem, QWhere> {
  QueryBuilder<EpisodeItem, EpisodeItem, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension EpisodeItemQueryWhere
    on QueryBuilder<EpisodeItem, EpisodeItem, QWhereClause> {
  QueryBuilder<EpisodeItem, EpisodeItem, QAfterWhereClause> isarIdEqualTo(
      int isarId) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: isarId,
      includeLower: true,
      upper: isarId,
      includeUpper: true,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterWhereClause> isarIdGreaterThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: isarId, includeLower: include),
    );
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterWhereClause> isarIdLessThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: isarId, includeUpper: include),
    );
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterWhereClause> isarIdBetween(
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

extension EpisodeItemQueryFilter
    on QueryBuilder<EpisodeItem, EpisodeItem, QFilterCondition> {
  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> durationEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'duration',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      durationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'duration',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      durationLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'duration',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> durationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'duration',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      episodeNumberEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'episodeNumber',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      episodeNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'episodeNumber',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      episodeNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'episodeNumber',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      episodeNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'episodeNumber',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> fullIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fullId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      fullIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fullId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> fullIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fullId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> fullIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fullId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      fullIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fullId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> fullIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fullId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> fullIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'fullId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> fullIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'fullId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> isarIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> isarIdEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      isarIdGreaterThan(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      playableQualitiesAnyEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'playableQualities',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      playableQualitiesAnyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'playableQualities',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      playableQualitiesAnyLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'playableQualities',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      playableQualitiesAnyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'playableQualities',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> positionEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'position',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      positionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'position',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      positionLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'position',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition> positionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'position',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      seasonNumberEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'seasonNumber',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      seasonNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'seasonNumber',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      seasonNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'seasonNumber',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      seasonNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'seasonNumber',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      subtitlesFileUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'subtitlesFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      subtitlesFileUrlGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'subtitlesFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      subtitlesFileUrlLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'subtitlesFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      subtitlesFileUrlBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'subtitlesFileUrl',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      subtitlesFileUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'subtitlesFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      subtitlesFileUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'subtitlesFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      subtitlesFileUrlContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'subtitlesFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      subtitlesFileUrlMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'subtitlesFileUrl',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      updatedAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'updatedAt',
      value: null,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'updatedAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      videoFileUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'videoFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      videoFileUrlGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'videoFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      videoFileUrlLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'videoFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      videoFileUrlBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'videoFileUrl',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      videoFileUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'videoFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      videoFileUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'videoFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      videoFileUrlContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'videoFileUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterFilterCondition>
      videoFileUrlMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'videoFileUrl',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension EpisodeItemQueryLinks
    on QueryBuilder<EpisodeItem, EpisodeItem, QFilterCondition> {}

extension EpisodeItemQueryWhereSortBy
    on QueryBuilder<EpisodeItem, EpisodeItem, QSortBy> {
  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByDuration() {
    return addSortByInternal('duration', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByDurationDesc() {
    return addSortByInternal('duration', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByEpisodeNumber() {
    return addSortByInternal('episodeNumber', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy>
      sortByEpisodeNumberDesc() {
    return addSortByInternal('episodeNumber', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByFullId() {
    return addSortByInternal('fullId', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByFullIdDesc() {
    return addSortByInternal('fullId', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByPosition() {
    return addSortByInternal('position', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByPositionDesc() {
    return addSortByInternal('position', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortBySeasonNumber() {
    return addSortByInternal('seasonNumber', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy>
      sortBySeasonNumberDesc() {
    return addSortByInternal('seasonNumber', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy>
      sortBySubtitlesFileUrl() {
    return addSortByInternal('subtitlesFileUrl', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy>
      sortBySubtitlesFileUrlDesc() {
    return addSortByInternal('subtitlesFileUrl', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByUpdatedAt() {
    return addSortByInternal('updatedAt', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByUpdatedAtDesc() {
    return addSortByInternal('updatedAt', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> sortByVideoFileUrl() {
    return addSortByInternal('videoFileUrl', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy>
      sortByVideoFileUrlDesc() {
    return addSortByInternal('videoFileUrl', Sort.desc);
  }
}

extension EpisodeItemQueryWhereSortThenBy
    on QueryBuilder<EpisodeItem, EpisodeItem, QSortThenBy> {
  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByDuration() {
    return addSortByInternal('duration', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByDurationDesc() {
    return addSortByInternal('duration', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByEpisodeNumber() {
    return addSortByInternal('episodeNumber', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy>
      thenByEpisodeNumberDesc() {
    return addSortByInternal('episodeNumber', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByFullId() {
    return addSortByInternal('fullId', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByFullIdDesc() {
    return addSortByInternal('fullId', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByPosition() {
    return addSortByInternal('position', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByPositionDesc() {
    return addSortByInternal('position', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenBySeasonNumber() {
    return addSortByInternal('seasonNumber', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy>
      thenBySeasonNumberDesc() {
    return addSortByInternal('seasonNumber', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy>
      thenBySubtitlesFileUrl() {
    return addSortByInternal('subtitlesFileUrl', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy>
      thenBySubtitlesFileUrlDesc() {
    return addSortByInternal('subtitlesFileUrl', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByUpdatedAt() {
    return addSortByInternal('updatedAt', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByUpdatedAtDesc() {
    return addSortByInternal('updatedAt', Sort.desc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy> thenByVideoFileUrl() {
    return addSortByInternal('videoFileUrl', Sort.asc);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QAfterSortBy>
      thenByVideoFileUrlDesc() {
    return addSortByInternal('videoFileUrl', Sort.desc);
  }
}

extension EpisodeItemQueryWhereDistinct
    on QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> {
  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctByDuration() {
    return addDistinctByInternal('duration');
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctByEpisodeNumber() {
    return addDistinctByInternal('episodeNumber');
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctByFullId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fullId', caseSensitive: caseSensitive);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctByPosition() {
    return addDistinctByInternal('position');
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctBySeasonNumber() {
    return addDistinctByInternal('seasonNumber');
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctBySubtitlesFileUrl(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('subtitlesFileUrl',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctByUpdatedAt() {
    return addDistinctByInternal('updatedAt');
  }

  QueryBuilder<EpisodeItem, EpisodeItem, QDistinct> distinctByVideoFileUrl(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('videoFileUrl', caseSensitive: caseSensitive);
  }
}

extension EpisodeItemQueryProperty
    on QueryBuilder<EpisodeItem, EpisodeItem, QQueryProperty> {
  QueryBuilder<EpisodeItem, int, QQueryOperations> durationProperty() {
    return addPropertyNameInternal('duration');
  }

  QueryBuilder<EpisodeItem, int, QQueryOperations> episodeNumberProperty() {
    return addPropertyNameInternal('episodeNumber');
  }

  QueryBuilder<EpisodeItem, String, QQueryOperations> fullIdProperty() {
    return addPropertyNameInternal('fullId');
  }

  QueryBuilder<EpisodeItem, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<EpisodeItem, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<EpisodeItem, String, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<EpisodeItem, List<int>, QQueryOperations>
      playableQualitiesProperty() {
    return addPropertyNameInternal('playableQualities');
  }

  QueryBuilder<EpisodeItem, int, QQueryOperations> positionProperty() {
    return addPropertyNameInternal('position');
  }

  QueryBuilder<EpisodeItem, int, QQueryOperations> seasonNumberProperty() {
    return addPropertyNameInternal('seasonNumber');
  }

  QueryBuilder<EpisodeItem, String, QQueryOperations>
      subtitlesFileUrlProperty() {
    return addPropertyNameInternal('subtitlesFileUrl');
  }

  QueryBuilder<EpisodeItem, DateTime?, QQueryOperations> updatedAtProperty() {
    return addPropertyNameInternal('updatedAt');
  }

  QueryBuilder<EpisodeItem, String, QQueryOperations> videoFileUrlProperty() {
    return addPropertyNameInternal('videoFileUrl');
  }
}
