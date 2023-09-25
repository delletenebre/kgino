// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetMediaItemCollection on Isar {
  IsarCollection<String, MediaItem> get mediaItems => this.collection();
}

const MediaItemSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'MediaItem',
    idName: 'isarDb',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'onlineService',
        type: IsarType.byte,
        enumMap: {"none": 0, "filmix": 1},
      ),
      IsarPropertySchema(
        name: 'type',
        type: IsarType.byte,
        enumMap: {"none": 0, "show": 1, "movie": 2},
      ),
      IsarPropertySchema(
        name: 'id',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'title',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'originalTitle',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'poster',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'voiceActing',
        type: IsarType.object,
        target: 'VoiceActing',
      ),
      IsarPropertySchema(
        name: 'subtitlesEnabled',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'bookmarked',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'isarDb',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'backdrop',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, MediaItem>(
    serialize: serializeMediaItem,
    deserialize: deserializeMediaItem,
    deserializeProperty: deserializeMediaItemProp,
  ),
  embeddedSchemas: [VoiceActingSchema],
);

@isarProtected
int serializeMediaItem(IsarWriter writer, MediaItem object) {
  IsarCore.writeByte(writer, 1, object.onlineService.index);
  IsarCore.writeByte(writer, 2, object.type.index);
  IsarCore.writeString(writer, 3, object.id);
  IsarCore.writeString(writer, 4, object.title);
  IsarCore.writeString(writer, 5, object.originalTitle);
  IsarCore.writeString(writer, 6, object.poster);
  {
    final value = object.voiceActing;
    final objectWriter = IsarCore.beginObject(writer, 7);
    serializeVoiceActing(objectWriter, value);
    IsarCore.endObject(writer, objectWriter);
  }
  IsarCore.writeBool(writer, 8, object.subtitlesEnabled);
  IsarCore.writeLong(
      writer,
      9,
      object.bookmarked?.toUtc().microsecondsSinceEpoch ??
          -9223372036854775808);
  IsarCore.writeString(writer, 10, object.isarDb);
  IsarCore.writeString(writer, 11, object.backdrop);
  return Isar.fastHash(object.isarDb);
}

@isarProtected
MediaItem deserializeMediaItem(IsarReader reader) {
  final OnlineService _onlineService;
  {
    if (IsarCore.readNull(reader, 1)) {
      _onlineService = OnlineService.none;
    } else {
      _onlineService = _mediaItemOnlineService[IsarCore.readByte(reader, 1)] ??
          OnlineService.none;
    }
  }
  final MediaItemType _type;
  {
    if (IsarCore.readNull(reader, 2)) {
      _type = MediaItemType.none;
    } else {
      _type =
          _mediaItemType[IsarCore.readByte(reader, 2)] ?? MediaItemType.none;
    }
  }
  final String _id;
  _id = IsarCore.readString(reader, 3) ?? '';
  final String _title;
  _title = IsarCore.readString(reader, 4) ?? '';
  final String _originalTitle;
  _originalTitle = IsarCore.readString(reader, 5) ?? '';
  final String _poster;
  _poster = IsarCore.readString(reader, 6) ?? '';
  final VoiceActing _voiceActing;
  {
    final objectReader = IsarCore.readObject(reader, 7);
    if (objectReader.isNull) {
      _voiceActing = const VoiceActing();
    } else {
      final embedded = deserializeVoiceActing(objectReader);
      IsarCore.freeReader(objectReader);
      _voiceActing = embedded;
    }
  }
  final bool _subtitlesEnabled;
  _subtitlesEnabled = IsarCore.readBool(reader, 8);
  final DateTime? _bookmarked;
  {
    final value = IsarCore.readLong(reader, 9);
    if (value == -9223372036854775808) {
      _bookmarked = null;
    } else {
      _bookmarked =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final object = MediaItem(
    onlineService: _onlineService,
    type: _type,
    id: _id,
    title: _title,
    originalTitle: _originalTitle,
    poster: _poster,
    voiceActing: _voiceActing,
    subtitlesEnabled: _subtitlesEnabled,
    bookmarked: _bookmarked,
  );
  return object;
}

@isarProtected
dynamic deserializeMediaItemProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      {
        if (IsarCore.readNull(reader, 1)) {
          return OnlineService.none;
        } else {
          return _mediaItemOnlineService[IsarCore.readByte(reader, 1)] ??
              OnlineService.none;
        }
      }
    case 2:
      {
        if (IsarCore.readNull(reader, 2)) {
          return MediaItemType.none;
        } else {
          return _mediaItemType[IsarCore.readByte(reader, 2)] ??
              MediaItemType.none;
        }
      }
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      return IsarCore.readString(reader, 6) ?? '';
    case 7:
      {
        final objectReader = IsarCore.readObject(reader, 7);
        if (objectReader.isNull) {
          return const VoiceActing();
        } else {
          final embedded = deserializeVoiceActing(objectReader);
          IsarCore.freeReader(objectReader);
          return embedded;
        }
      }
    case 8:
      return IsarCore.readBool(reader, 8);
    case 9:
      {
        final value = IsarCore.readLong(reader, 9);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 10:
      return IsarCore.readString(reader, 10) ?? '';
    case 11:
      return IsarCore.readString(reader, 11) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _MediaItemUpdate {
  bool call({
    required String isarDb,
    OnlineService? onlineService,
    MediaItemType? type,
    String? id,
    String? title,
    String? originalTitle,
    String? poster,
    bool? subtitlesEnabled,
    DateTime? bookmarked,
    String? backdrop,
  });
}

class _MediaItemUpdateImpl implements _MediaItemUpdate {
  const _MediaItemUpdateImpl(this.collection);

  final IsarCollection<String, MediaItem> collection;

  @override
  bool call({
    required String isarDb,
    Object? onlineService = ignore,
    Object? type = ignore,
    Object? id = ignore,
    Object? title = ignore,
    Object? originalTitle = ignore,
    Object? poster = ignore,
    Object? subtitlesEnabled = ignore,
    Object? bookmarked = ignore,
    Object? backdrop = ignore,
  }) {
    return collection.updateProperties([
          isarDb
        ], {
          if (onlineService != ignore) 1: onlineService as OnlineService?,
          if (type != ignore) 2: type as MediaItemType?,
          if (id != ignore) 3: id as String?,
          if (title != ignore) 4: title as String?,
          if (originalTitle != ignore) 5: originalTitle as String?,
          if (poster != ignore) 6: poster as String?,
          if (subtitlesEnabled != ignore) 8: subtitlesEnabled as bool?,
          if (bookmarked != ignore) 9: bookmarked as DateTime?,
          if (backdrop != ignore) 11: backdrop as String?,
        }) >
        0;
  }
}

sealed class _MediaItemUpdateAll {
  int call({
    required List<String> isarDb,
    OnlineService? onlineService,
    MediaItemType? type,
    String? id,
    String? title,
    String? originalTitle,
    String? poster,
    bool? subtitlesEnabled,
    DateTime? bookmarked,
    String? backdrop,
  });
}

class _MediaItemUpdateAllImpl implements _MediaItemUpdateAll {
  const _MediaItemUpdateAllImpl(this.collection);

  final IsarCollection<String, MediaItem> collection;

  @override
  int call({
    required List<String> isarDb,
    Object? onlineService = ignore,
    Object? type = ignore,
    Object? id = ignore,
    Object? title = ignore,
    Object? originalTitle = ignore,
    Object? poster = ignore,
    Object? subtitlesEnabled = ignore,
    Object? bookmarked = ignore,
    Object? backdrop = ignore,
  }) {
    return collection.updateProperties(isarDb, {
      if (onlineService != ignore) 1: onlineService as OnlineService?,
      if (type != ignore) 2: type as MediaItemType?,
      if (id != ignore) 3: id as String?,
      if (title != ignore) 4: title as String?,
      if (originalTitle != ignore) 5: originalTitle as String?,
      if (poster != ignore) 6: poster as String?,
      if (subtitlesEnabled != ignore) 8: subtitlesEnabled as bool?,
      if (bookmarked != ignore) 9: bookmarked as DateTime?,
      if (backdrop != ignore) 11: backdrop as String?,
    });
  }
}

extension MediaItemUpdate on IsarCollection<String, MediaItem> {
  _MediaItemUpdate get update => _MediaItemUpdateImpl(this);

  _MediaItemUpdateAll get updateAll => _MediaItemUpdateAllImpl(this);
}

sealed class _MediaItemQueryUpdate {
  int call({
    OnlineService? onlineService,
    MediaItemType? type,
    String? id,
    String? title,
    String? originalTitle,
    String? poster,
    bool? subtitlesEnabled,
    DateTime? bookmarked,
    String? backdrop,
  });
}

class _MediaItemQueryUpdateImpl implements _MediaItemQueryUpdate {
  const _MediaItemQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<MediaItem> query;
  final int? limit;

  @override
  int call({
    Object? onlineService = ignore,
    Object? type = ignore,
    Object? id = ignore,
    Object? title = ignore,
    Object? originalTitle = ignore,
    Object? poster = ignore,
    Object? subtitlesEnabled = ignore,
    Object? bookmarked = ignore,
    Object? backdrop = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (onlineService != ignore) 1: onlineService as OnlineService?,
      if (type != ignore) 2: type as MediaItemType?,
      if (id != ignore) 3: id as String?,
      if (title != ignore) 4: title as String?,
      if (originalTitle != ignore) 5: originalTitle as String?,
      if (poster != ignore) 6: poster as String?,
      if (subtitlesEnabled != ignore) 8: subtitlesEnabled as bool?,
      if (bookmarked != ignore) 9: bookmarked as DateTime?,
      if (backdrop != ignore) 11: backdrop as String?,
    });
  }
}

extension MediaItemQueryUpdate on IsarQuery<MediaItem> {
  _MediaItemQueryUpdate get updateFirst =>
      _MediaItemQueryUpdateImpl(this, limit: 1);

  _MediaItemQueryUpdate get updateAll => _MediaItemQueryUpdateImpl(this);
}

class _MediaItemQueryBuilderUpdateImpl implements _MediaItemQueryUpdate {
  const _MediaItemQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<MediaItem, MediaItem, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? onlineService = ignore,
    Object? type = ignore,
    Object? id = ignore,
    Object? title = ignore,
    Object? originalTitle = ignore,
    Object? poster = ignore,
    Object? subtitlesEnabled = ignore,
    Object? bookmarked = ignore,
    Object? backdrop = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (onlineService != ignore) 1: onlineService as OnlineService?,
        if (type != ignore) 2: type as MediaItemType?,
        if (id != ignore) 3: id as String?,
        if (title != ignore) 4: title as String?,
        if (originalTitle != ignore) 5: originalTitle as String?,
        if (poster != ignore) 6: poster as String?,
        if (subtitlesEnabled != ignore) 8: subtitlesEnabled as bool?,
        if (bookmarked != ignore) 9: bookmarked as DateTime?,
        if (backdrop != ignore) 11: backdrop as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension MediaItemQueryBuilderUpdate
    on QueryBuilder<MediaItem, MediaItem, QOperations> {
  _MediaItemQueryUpdate get updateFirst =>
      _MediaItemQueryBuilderUpdateImpl(this, limit: 1);

  _MediaItemQueryUpdate get updateAll => _MediaItemQueryBuilderUpdateImpl(this);
}

const _mediaItemOnlineService = {
  0: OnlineService.none,
  1: OnlineService.filmix,
};
const _mediaItemType = {
  0: MediaItemType.none,
  1: MediaItemType.show,
  2: MediaItemType.movie,
};

extension MediaItemQueryFilter
    on QueryBuilder<MediaItem, MediaItem, QFilterCondition> {
  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      onlineServiceEqualTo(
    OnlineService value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      onlineServiceGreaterThan(
    OnlineService value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      onlineServiceGreaterThanOrEqualTo(
    OnlineService value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      onlineServiceLessThan(
    OnlineService value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      onlineServiceLessThanOrEqualTo(
    OnlineService value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      onlineServiceBetween(
    OnlineService lower,
    OnlineService upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower.index,
          upper: upper.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> typeEqualTo(
    MediaItemType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> typeGreaterThan(
    MediaItemType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      typeGreaterThanOrEqualTo(
    MediaItemType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> typeLessThan(
    MediaItemType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      typeLessThanOrEqualTo(
    MediaItemType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> typeBetween(
    MediaItemType lower,
    MediaItemType upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower.index,
          upper: upper.index,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      titleGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> titleLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      titleLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleEqualTo(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleGreaterThan(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleGreaterThanOrEqualTo(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleLessThan(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleLessThanOrEqualTo(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleBetween(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleStartsWith(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleEndsWith(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      originalTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> posterEqualTo(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> posterGreaterThan(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      posterGreaterThanOrEqualTo(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> posterLessThan(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      posterLessThanOrEqualTo(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> posterBetween(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> posterStartsWith(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> posterEndsWith(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> posterContains(
      String value,
      {bool caseSensitive = true}) {
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> posterMatches(
      String pattern,
      {bool caseSensitive = true}) {
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> posterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> posterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      subtitlesEnabledEqualTo(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> bookmarkedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      bookmarkedIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> bookmarkedEqualTo(
    DateTime? value,
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      bookmarkedGreaterThan(
    DateTime? value,
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      bookmarkedGreaterThanOrEqualTo(
    DateTime? value,
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> bookmarkedLessThan(
    DateTime? value,
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      bookmarkedLessThanOrEqualTo(
    DateTime? value,
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> bookmarkedBetween(
    DateTime? lower,
    DateTime? upper,
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> isarDbEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> isarDbGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      isarDbGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> isarDbLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      isarDbLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> isarDbBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> isarDbStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> isarDbEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> isarDbContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> isarDbMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 10,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> isarDbIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> isarDbIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> backdropEqualTo(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> backdropGreaterThan(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      backdropGreaterThanOrEqualTo(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> backdropLessThan(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      backdropLessThanOrEqualTo(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> backdropBetween(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> backdropStartsWith(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> backdropEndsWith(
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> backdropContains(
      String value,
      {bool caseSensitive = true}) {
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> backdropMatches(
      String pattern,
      {bool caseSensitive = true}) {
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

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> backdropIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition>
      backdropIsNotEmpty() {
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

extension MediaItemQueryObject
    on QueryBuilder<MediaItem, MediaItem, QFilterCondition> {
  QueryBuilder<MediaItem, MediaItem, QAfterFilterCondition> voiceActing(
      FilterQuery<VoiceActing> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, 7);
    });
  }
}

extension MediaItemQuerySortBy on QueryBuilder<MediaItem, MediaItem, QSortBy> {
  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByOnlineService() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByOnlineServiceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByTitleDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByOriginalTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByOriginalTitleDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByPoster(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByPosterDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortBySubtitlesEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy>
      sortBySubtitlesEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByIsarDb(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByIsarDbDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByBackdrop(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> sortByBackdropDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension MediaItemQuerySortThenBy
    on QueryBuilder<MediaItem, MediaItem, QSortThenBy> {
  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByOnlineService() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByOnlineServiceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByTitleDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByOriginalTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByOriginalTitleDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByPoster(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByPosterDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenBySubtitlesEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy>
      thenBySubtitlesEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByIsarDb(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByIsarDbDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByBackdrop(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterSortBy> thenByBackdropDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension MediaItemQueryWhereDistinct
    on QueryBuilder<MediaItem, MediaItem, QDistinct> {
  QueryBuilder<MediaItem, MediaItem, QAfterDistinct> distinctByOnlineService() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterDistinct> distinctByOriginalTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterDistinct> distinctByPoster(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterDistinct>
      distinctBySubtitlesEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterDistinct> distinctByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<MediaItem, MediaItem, QAfterDistinct> distinctByBackdrop(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11, caseSensitive: caseSensitive);
    });
  }
}

extension MediaItemQueryProperty1
    on QueryBuilder<MediaItem, MediaItem, QProperty> {
  QueryBuilder<MediaItem, OnlineService, QAfterProperty>
      onlineServiceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MediaItem, MediaItemType, QAfterProperty> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MediaItem, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MediaItem, String, QAfterProperty> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MediaItem, String, QAfterProperty> originalTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MediaItem, String, QAfterProperty> posterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MediaItem, VoiceActing, QAfterProperty> voiceActingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MediaItem, bool, QAfterProperty> subtitlesEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MediaItem, DateTime?, QAfterProperty> bookmarkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MediaItem, String, QAfterProperty> isarDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MediaItem, String, QAfterProperty> backdropProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

extension MediaItemQueryProperty2<R>
    on QueryBuilder<MediaItem, R, QAfterProperty> {
  QueryBuilder<MediaItem, (R, OnlineService), QAfterProperty>
      onlineServiceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MediaItem, (R, MediaItemType), QAfterProperty> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MediaItem, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MediaItem, (R, String), QAfterProperty> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MediaItem, (R, String), QAfterProperty> originalTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MediaItem, (R, String), QAfterProperty> posterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MediaItem, (R, VoiceActing), QAfterProperty>
      voiceActingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MediaItem, (R, bool), QAfterProperty>
      subtitlesEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MediaItem, (R, DateTime?), QAfterProperty> bookmarkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MediaItem, (R, String), QAfterProperty> isarDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MediaItem, (R, String), QAfterProperty> backdropProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

extension MediaItemQueryProperty3<R1, R2>
    on QueryBuilder<MediaItem, (R1, R2), QAfterProperty> {
  QueryBuilder<MediaItem, (R1, R2, OnlineService), QOperations>
      onlineServiceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MediaItem, (R1, R2, MediaItemType), QOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MediaItem, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MediaItem, (R1, R2, String), QOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MediaItem, (R1, R2, String), QOperations>
      originalTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MediaItem, (R1, R2, String), QOperations> posterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MediaItem, (R1, R2, VoiceActing), QOperations>
      voiceActingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MediaItem, (R1, R2, bool), QOperations>
      subtitlesEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MediaItem, (R1, R2, DateTime?), QOperations>
      bookmarkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MediaItem, (R1, R2, String), QOperations> isarDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MediaItem, (R1, R2, String), QOperations> backdropProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) => MediaItem(
      id: const StringConverter().fromJson(json['id']),
      title: json['title'] as String,
      originalTitle: json['originalTitle'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      poster: json['poster'] as String,
      year: json['year'] == null
          ? ''
          : const StringConverter().fromJson(json['year']),
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      voiceActing: json['voiceActing'] == null
          ? const VoiceActing()
          : VoiceActing.fromJson(json['voiceActing'] as Map<String, dynamic>),
      voiceActings: (json['voiceActings'] as List<dynamic>?)
              ?.map((e) => VoiceActing.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subtitlesEnabled: json['subtitlesEnabled'] as bool? ?? false,
      imdbRating: json['imdbRating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['imdbRating']),
      kinopoiskRating: json['kinopoiskRating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['kinopoiskRating']),
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((e) => MediaItemSeason.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      bookmarked: json['bookmarked'] == null
          ? null
          : DateTime.parse(json['bookmarked'] as String),
      onlineService:
          $enumDecodeNullable(_$OnlineServiceEnumMap, json['onlineService']) ??
              OnlineService.none,
    );

Map<String, dynamic> _$MediaItemToJson(MediaItem instance) => <String, dynamic>{
      'onlineService': _$OnlineServiceEnumMap[instance.onlineService]!,
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
      'originalTitle': instance.originalTitle,
      'overview': instance.overview,
      'poster': instance.poster,
      'year': const StringConverter().toJson(instance.year),
      'genres': instance.genres,
      'countries': instance.countries,
      'voiceActing': instance.voiceActing.toJson(),
      'voiceActings': instance.voiceActings.map((e) => e.toJson()).toList(),
      'subtitlesEnabled': instance.subtitlesEnabled,
      'bookmarked': instance.bookmarked?.toIso8601String(),
      'imdbRating': const DoubleConverter().toJson(instance.imdbRating),
      'kinopoiskRating':
          const DoubleConverter().toJson(instance.kinopoiskRating),
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
    };

const _$OnlineServiceEnumMap = {
  OnlineService.none: 'none',
  OnlineService.filmix: 'filmix',
};
