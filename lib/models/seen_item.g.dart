// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seen_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeenItemAdapter extends TypeAdapter<SeenItem> {
  @override
  final int typeId = 1;

  @override
  SeenItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeenItem(
      tag: fields[0] as String,
      id: fields[1] as String,
      name: fields[2] as String,
      updatedAt: fields[4] as DateTime,
      episodes: (fields[5] as Map).cast<String, SeenEpisode>(),
      subtitlesEnabled: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SeenItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.tag)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.subtitlesEnabled)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.episodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeenItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SeenEpisodeAdapter extends TypeAdapter<SeenEpisode> {
  @override
  final int typeId = 2;

  @override
  SeenEpisode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeenEpisode(
      id: fields[0] as String,
      position: fields[1] as int,
      duration: fields[2] as int,
      updatedAt: fields[3] as DateTime,
      name: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SeenEpisode obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeenEpisodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
