import '../../models/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/common/utils/hive_mappers.dart';
import 'package:pokedex/error/exceptions.dart';

import '../../models/pokemon.dart';
import '../../utils/const/hive_boxes.dart';
import 'generated/hive_pokemon.dart';
import 'local_pokemon_datasource.dart';

abstract class LocalPokemonDataSource {
  Future<void> cache(Pokemon pokemon);
  Future<bool> exists(Pokemon pokemon);
  Future<bool> existsId(int pokemonId);
  Future<Pokemon> getId(int pokemonId);
}

class HivePokemonDataSource implements LocalPokemonDataSource {
  final box = Hive.box<HivePokemon>(HiveBoxes.pokemon);

  @override
  Future<void> cache(Pokemon pokemon) async {
    await box.put(pokemon.id, pokemon.toHiveModel());
  }

  @override
  Future<bool> exists(Pokemon pokemon) async {
    return pokemon.toHiveModel().isInBox;
  }

  @override
  Future<bool> existsId(int pokemonId) async {
    return box.containsKey(pokemonId);
  }

  @override
  Future<Pokemon> getId(int pokemonId) async {
    var hivePokemon = box.get(pokemonId);

    if (hivePokemon == null) throw HiveNotFound();
    return hivePokemon.toEntity();
  }
}
