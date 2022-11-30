// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TskgFavoriteAdapter extends TypeAdapter<TskgFavorite> {
  @override
  final int typeId = 0;

  @override
  TskgFavorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TskgFavorite(
      showId: fields[0] as String,
      name: fields[1] as String,
      episodeCount: fields[2] as int,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TskgFavorite obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.showId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.episodeCount)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TskgFavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
