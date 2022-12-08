// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteTypeAdapter extends TypeAdapter<SiteType> {
  @override
  final int typeId = 7;

  @override
  SiteType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SiteType.ockg;
      case 1:
        return SiteType.tskg;
      default:
        return SiteType.ockg;
    }
  }

  @override
  void write(BinaryWriter writer, SiteType obj) {
    switch (obj) {
      case SiteType.ockg:
        writer.writeByte(0);
        break;
      case SiteType.tskg:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SiteTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MovieItemAdapter extends TypeAdapter<_$_MovieItem> {
  @override
  final int typeId = 5;

  @override
  _$_MovieItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_MovieItem(
      type: fields[0] as SiteType,
      id: fields[1] as String,
      name: fields[2] as String,
      posterUrl: fields[3] as String,
      subtitlesEnabled: fields[4] as bool,
      favorite: fields[5] as bool,
      updatedAt: fields[6] as DateTime,
      episodes: (fields[7] as Map).cast<String, EpisodeItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$_MovieItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.posterUrl)
      ..writeByte(4)
      ..write(obj.subtitlesEnabled)
      ..writeByte(5)
      ..write(obj.favorite)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.episodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
