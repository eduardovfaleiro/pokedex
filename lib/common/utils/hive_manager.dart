import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/common/datasources/local/models/hive_pokemon.dart';
import 'package:pokedex/common/datasources/local/models/hive_pokemon_stats.dart';
import 'package:pokedex/common/utils/const/hive_boxes.dart';

class HiveManager {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(HivePokemonAdapter());
    Hive.registerAdapter(HivePokemonStatsAdapter());

    await Hive.openBox<HivePokemon>(HiveBoxes.pokemon);
    await Hive.openBox<Map<dynamic, dynamic>>(HiveBoxes.pokemonUrl);
  }
}
