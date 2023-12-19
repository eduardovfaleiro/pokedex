// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final int typeId = 0;

  @override
  Pokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemon(
      id: fields[0] as int,
      name: fields[1] as String,
      types: (fields[2] as List).cast<dynamic>(),
      sprite: (fields[3] as Map).cast<String, dynamic>(),
      heightDecimeter: fields[4] as int,
      weightHectogram: fields[5] as int,
      stats: fields[6] as PokemonStats,
    )..mixedColor = fields[7] as Color;
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.types)
      ..writeByte(3)
      ..write(obj.sprite)
      ..writeByte(4)
      ..write(obj.heightDecimeter)
      ..writeByte(5)
      ..write(obj.weightHectogram)
      ..writeByte(6)
      ..write(obj.stats)
      ..writeByte(7)
      ..write(obj.mixedColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
