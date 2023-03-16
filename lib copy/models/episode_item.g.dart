// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpisodeItemAdapter extends TypeAdapter<EpisodeItem> {
  @override
  final int typeId = 12;

  @override
  EpisodeItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EpisodeItem(
      id: fields[0] as String,
      name: fields[1] as String,
      position: fields[2] as int,
      duration: fields[3] as int,
      updatedAt: fields[4] as DateTime?,
      seasonNumber: fields[5] as int,
      episodeNumber: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EpisodeItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.seasonNumber)
      ..writeByte(6)
      ..write(obj.episodeNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
