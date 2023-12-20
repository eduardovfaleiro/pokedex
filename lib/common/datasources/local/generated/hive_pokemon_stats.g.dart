// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_pokemon_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePokemonStatsAdapter extends TypeAdapter<HivePokemonStats> {
  @override
  final int typeId = 1;

  @override
  HivePokemonStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePokemonStats(
      health: fields[0] as int,
      attack: fields[1] as int,
      defense: fields[2] as int,
      specialAttack: fields[3] as int,
      specialDefense: fields[4] as int,
      speed: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HivePokemonStats obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.health)
      ..writeByte(1)
      ..write(obj.attack)
      ..writeByte(2)
      ..write(obj.defense)
      ..writeByte(3)
      ..write(obj.specialAttack)
      ..writeByte(4)
      ..write(obj.specialDefense)
      ..writeByte(5)
      ..write(obj.speed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePokemonStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
