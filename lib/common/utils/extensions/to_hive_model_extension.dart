import '../../datasources/local/models/hive_pokemon.dart';
import '../../datasources/local/models/hive_pokemon_stats.dart';
import '../../models/pokemon.dart';
import '../../models/pokemon_stats.dart';

extension PokemonExtension on Pokemon {
  HivePokemon toHiveModel() {
    return HivePokemon(
      id: id,
      name: name,
      imageUrls: imageUrls,
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
