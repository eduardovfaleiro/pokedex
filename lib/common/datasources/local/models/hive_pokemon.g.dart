// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePokemonAdapter extends TypeAdapter<HivePokemon> {
  @override
  final int typeId = 0;

  @override
  HivePokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePokemon(
      id: fields[0] as int,
      name: fields[1] as String,
      types: (fields[2] as List).cast<dynamic>(),
      imageUrls: (fields[3] as List).cast<String>(),
      heightDecimeter: fields[4] as int,
      weightHectogram: fields[5] as int,
      stats: fields[6] as HivePokemonStats,
    );
  }

  @override
  void write(BinaryWriter writer, HivePokemon obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.types)
      ..writeByte(3)
      ..write(obj.imageUrls)
      ..writeByte(4)
      ..write(obj.heightDecimeter)
      ..writeByte(5)
      ..write(obj.weightHectogram)
      ..writeByte(6)
      ..write(obj.stats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
