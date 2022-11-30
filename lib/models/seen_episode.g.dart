// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seen_episode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeenEpisodeAdapter extends TypeAdapter<SeenEpisode> {
  @override
  final int typeId = 1;

  @override
  SeenEpisode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeenEpisode(
      id: fields[0] as String,
      parentId: fields[1] as String,
      position: fields[2] as int,
      duration: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SeenEpisode obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.parentId)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.duration);
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
