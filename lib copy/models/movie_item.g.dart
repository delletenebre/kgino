// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieItemAdapter extends TypeAdapter<MovieItem> {
  @override
  final int typeId = 11;

  @override
  MovieItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieItem(
      type: fields[0] as ServiceName,
      id: fields[1] as String,
      name: fields[2] as String,
      posterUrl: fields[3] as String,
      subtitlesEnabled: fields[4] as bool,
      favorite: fields[5] as bool,
      updatedAt: fields[6] as DateTime?,
      episodes: (fields[7] as List?)?.cast<EpisodeItem>(),
      voiceActing: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovieItem obj) {
    writer
      ..writeByte(9)
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
      ..write(obj.episodes)
      ..writeByte(8)
      ..write(obj.voiceActing);
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

class MovieItemTypeAdapter extends TypeAdapter<ServiceName> {
  @override
  final int typeId = 7;

  @override
  ServiceName read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ServiceName.ockg;
      case 1:
        return ServiceName.tskg;
      case 2:
        return ServiceName.wcam;
      case 3:
        return ServiceName.folder;
      case 4:
        return ServiceName.flmx;
      default:
        return ServiceName.ockg;
    }
  }

  @override
  void write(BinaryWriter writer, ServiceName obj) {
    switch (obj) {
      case ServiceName.ockg:
        writer.writeByte(0);
        break;
      case ServiceName.tskg:
        writer.writeByte(1);
        break;
      case ServiceName.wcam:
        writer.writeByte(2);
        break;
      case ServiceName.folder:
        writer.writeByte(3);
        break;
      case ServiceName.flmx:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
