// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_pokemon_sprite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePokemonSpriteAdapter extends TypeAdapter<HivePokemonSprite> {
  @override
  final int typeId = 2;

  @override
  HivePokemonSprite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePokemonSprite(
      fields[0] as String,
      fields[1] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, HivePokemonSprite obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.bytes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePokemonSpriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
