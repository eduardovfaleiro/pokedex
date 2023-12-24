import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

part 'hive_pokemon_sprite.g.dart';

@HiveType(typeId: 2)
class HivePokemonSprite {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final Uint8List bytes;

  HivePokemonSprite(this.name, this.bytes);
}
