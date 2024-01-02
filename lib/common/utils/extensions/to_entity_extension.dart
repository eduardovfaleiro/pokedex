import '../../datasources/local_pokemon/models/hive_pokemon.dart';
import '../../datasources/local_pokemon/models/hive_pokemon_stats.dart';
import '../../models/pokemon.dart';
import '../../models/pokemon_stats.dart';

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
      imageUrls: imageUrls,
      heightDecimeter: heightDecimeter,
      weightHectogram: weightHectogram,
      stats: stats.toEntity(),
    );
  }
}
