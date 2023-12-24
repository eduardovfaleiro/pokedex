import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/common/datasources/local/models/hive_pokemon_sprite.dart';
import 'package:pokedex/common/models/pokemon_sprite.dart';
import 'package:pokedex/common/utils/const/hive_boxes.dart';

import '../../datasources/local/models/hive_pokemon.dart';
import '../../datasources/local/models/hive_pokemon_stats.dart';
import '../../models/pokemon.dart';
import '../../models/pokemon_stats.dart';

extension PokemonExtension on Pokemon {
  HivePokemon toHiveModel() {
    return HivePokemon(
      id: id,
      name: name,
      sprites: List.from(sprites.map((sprite) => sprite.toHiveModel())),
      stats: stats.toHiveModel(),
      types: types,
      weightHectogram: weightHectogram,
      heightDecimeter: heightDecimeter,
    );
  }
}

extension PokemonStatsExtension on PokemonStats {
  HivePokemonStats toHiveModel() {
    return HivePokemonStats(
      attack: attack,
      defense: defense,
      health: health,
      specialAttack: specialAttack,
      specialDefense: specialDefense,
      speed: speed,
    );
  }
}

extension PokemonSpriteExtension on PokemonSprite {
  HivePokemonSprite toHiveModel() {
    return HivePokemonSprite(name, bytes);
  }
}

extension HivePokemonStatsExtension on HivePokemonStats {
  PokemonStats toEntity() {
    return PokemonStats(
      health: health,
      attack: attack,
      defense: defense,
      specialAttack: specialAttack,
      specialDefense: specialDefense,
      speed: speed,
    );
  }
}

extension HivePokemonExtension on HivePokemon {
  Pokemon toEntity() {
    return Pokemon(
      id: id,
      name: name,
      types: types,
      sprites: List.from(sprites.map((sprite) => sprite.toHiveModel())),
      heightDecimeter: heightDecimeter,
      weightHectogram: weightHectogram,
      stats: stats.toEntity(),
    );
  }
}
