import '../../models/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/common/utils/hive_mappers.dart';
import 'package:pokedex/error/exceptions.dart';

import '../../models/pokemon.dart';
import '../../utils/const/consts.dart';
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
  final pokemonBox = Hive.box<HivePokemon>(HiveBoxes.pokemon);
  final pokemonNameUrlBox = Hive.box<HivePokemon>(HiveBoxes.pokemonNameUrl);

  @override
  Future<void> cache(Pokemon pokemon) async {
    await pokemonBox.put(pokemon.id, pokemon.toHiveModel());
  }

  @override
  Future<bool> exists(Pokemon pokemon) async {
    return pokemon.toHiveModel().isInBox;
  }

  @override
  Future<bool> existsId(int pokemonId) async {
    return pokemonBox.containsKey(pokemonId);
  }

  @override
  Future<Pokemon> getId(int pokemonId) async {
    var hivePokemon = pokemonBox.get(pokemonId);
    if (hivePokemon == null) throw HiveNotFound();

    return hivePokemon.toEntity();
  }
}
