import '../../models/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/common/utils/extensions/hive_mappers_extension.dart';
import 'package:pokedex/error/exceptions.dart';

import '../../models/pokemon.dart';
import '../../utils/const/consts.dart';
import '../../utils/const/hive_boxes.dart';
import 'generated/hive_pokemon.dart';
import 'local_pokemon_object_datasource.dart';

abstract class LocalPokemonObjectDataSource {
  Future<void> cache(Pokemon pokemon);
  Future<bool> exists(Pokemon pokemon);
  Future<bool> existsId(int pokemonId);
  Future<Pokemon> getId(int pokemonId);
  Future<int> getPokemonCount();
}

class HivePokemonObjectDataSource implements LocalPokemonObjectDataSource {
  final pokemonBox = Hive.box<HivePokemon>(HiveBoxes.pokemon);

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
    return pokemonBox.get(pokemonId)!.toEntity();
  }

  @override
  Future<int> getPokemonCount() async {
    return pokemonBox.length;
  }
}
