// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewed_show_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViewedShowModelAdapter extends TypeAdapter<ViewedShowModel> {
  @override
  final int typeId = 1;

  @override
  ViewedShowModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ViewedShowModel(
      fields[0] as String,
      (fields[1] as List).cast<ViewedEpisodeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ViewedShowModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.episodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewedShowModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
