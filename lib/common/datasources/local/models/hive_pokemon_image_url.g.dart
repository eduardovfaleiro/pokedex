// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_pokemon_image_url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePokemonImageUrlAdapter extends TypeAdapter<HivePokemonImageUrl> {
  @override
  final int typeId = 2;

  @override
  HivePokemonImageUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePokemonImageUrl(
      fields[1] as String,
      art: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HivePokemonImageUrl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.art)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePokemonImageUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
