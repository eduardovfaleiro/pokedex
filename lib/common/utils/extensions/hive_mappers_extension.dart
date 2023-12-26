import 'package:hive_flutter/hive_flutter.dart';

import '../../datasources/local/models/hive_pokemon.dart';
import '../../datasources/local/models/hive_pokemon_image_url.dart';
import '../../datasources/local/models/hive_pokemon_stats.dart';
import '../../models/pokemon.dart';
import '../../models/pokemon_image_url.dart';
import '../../models/pokemon_stats.dart';

extension PokemonExtension on Pokemon {
  HivePokemon toHiveModel() {
    return HivePokemon(
      id: id,
      name: name,
      images: List.from(images.map((e) => e.toHiveModel())),
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

extension PokemonImageUrlExtension on PokemonImageUrl {
  HivePokemonImageUrl toHiveModel() {
    return HivePokemonImageUrl(url, art: art);
  }
}

extension HivePokemonImageUrlExtension on HivePokemonImageUrl {
  PokemonImageUrl toEntity() {
    return PokemonImageUrl(url, art: art);
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
      images: List.from(images.map((e) => e.toEntity())),
      heightDecimeter: heightDecimeter,
      weightHectogram: weightHectogram,
      stats: stats.toEntity(),
    );
  }
}
