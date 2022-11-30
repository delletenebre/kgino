// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_seen_episode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TskgSeenEpisodeAdapter extends TypeAdapter<TskgSeenEpisode> {
  @override
  final int typeId = 1;

  @override
  TskgSeenEpisode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TskgSeenEpisode(
      id: fields[0] as int,
      position: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TskgSeenEpisode obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TskgSeenEpisodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
