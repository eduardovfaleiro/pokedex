import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/common/datasources/local/generated/hive_pokemon.dart';
import 'package:pokedex/common/datasources/local/generated/hive_pokemon_stats.dart';
import 'package:pokedex/common/utils/const/hive_boxes.dart';

import '../models/pokemon.dart';

class HiveManager {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(HivePokemonAdapter());
    Hive.registerAdapter(HivePokemonStatsAdapter());

    await Hive.openBox<HivePokemon>(HiveBoxes.pokemon);
  }
}
