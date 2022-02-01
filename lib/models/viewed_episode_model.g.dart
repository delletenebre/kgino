// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewed_episode_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViewedEpisodeModelAdapter extends TypeAdapter<ViewedEpisodeModel> {
  @override
  final int typeId = 2;

  @override
  ViewedEpisodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ViewedEpisodeModel(
      fields[0] as int,
      fields[1] as int,
      fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ViewedEpisodeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewedEpisodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
