import '../../models/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/common/utils/extensions/hive_mappers_extension.dart';
import 'package:pokedex/error/exceptions.dart';

import '../../models/pokemon.dart';
import '../../utils/const/consts.dart';
import '../../utils/const/hive_boxes.dart';
import 'models/hive_pokemon.dart';
import 'local_pokemon_datasource.dart';

abstract class LocalPokemonDataSource {
  Future<void> cache(Pokemon pokemon);
  Future<void> cachePokemonUrlList(List<Map<dynamic, dynamic>> pokemonUrlList);
  Future<Pokemon?> getId(int pokemonId);
  Future<List<Map<dynamic, dynamic>>> getPokemonUrlList();
}

class HivePokemonDataSource implements LocalPokemonDataSource {
  final pokemonBox = Hive.box<HivePokemon>(HiveBoxes.pokemon);
  final pokemonUrlBox = Hive.box<Map<dynamic, dynamic>>(HiveBoxes.pokemonUrl);

  @override
  Future<void> cache(Pokemon pokemon) async {
    await pokemonBox.put(pokemon.id, pokemon.toHiveModel());
  }

  @override
  Future<Pokemon?> getId(int pokemonId) async {
    var hivePokemon = pokemonBox.get(pokemonId);
    if (hivePokemon == null) return null;

    return hivePokemon.toEntity();
  }

  @override
  Future<List<Map<dynamic, dynamic>>> getPokemonUrlList() async {
    return List.from(pokemonUrlBox.values);
  }

  @override
  Future<void> cachePokemonUrlList(List<Map<dynamic, dynamic>> pokemonUrlList) async {
    for (int i = 0; i < pokemonUrlList.length; i++) {
      await pokemonUrlBox.add(pokemonUrlList[i]);
    }
  }
}
