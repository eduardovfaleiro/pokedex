import 'package:hive_flutter/hive_flutter.dart';

import '../utils/const/config_keys.dart';
import '../utils/const/consts.dart';
import '../utils/const/hive_boxes.dart';
import '../utils/const/pokemon_art.dart';

abstract class LocalConfigDataSource {
  Future<PokemonArt> getPokemonArt();
  Future<void> setPokemonArt(PokemonArt pokemonArt);
}

class HiveConfigDataSource implements LocalConfigDataSource {
  final configBox = Hive.box<dynamic>(HiveBoxes.config);

  @override
  Future<PokemonArt> getPokemonArt() async {
    return PokemonArt.name(configBox.get(ConfigKeys.pokemonArt, defaultValue: Consts.defaultPokemonArt.name));
  }

  @override
  Future<void> setPokemonArt(PokemonArt pokemonArt) async {
    await configBox.put(ConfigKeys.pokemonArt, pokemonArt.name);
  }
}
