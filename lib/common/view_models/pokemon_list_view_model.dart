// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/utils/page_state_controller.dart';

import '../../utils/const/pokemon_request_quantity.dart';
import '../models/pokemon.dart';

class PokemonListViewModel extends ChangeNotifier with PageStateController {
  final IPokemonRepository _pokemonRepository;

  PokemonListViewModel(this._pokemonRepository);

  final cachedPokemon = <Pokemon>[];

  Future<void> initialize() async {
    cachedPokemon.clear();
    await loadPokemon();
  }

  Future<void> loadPokemon() async {
    setPageState(LOADING);

    int cachedPokemonLength = cachedPokemon.length;

    for (int i = cachedPokemonLength + 1; i < pokemonRequestQuantity + cachedPokemonLength; i++) {
      cachedPokemon.add(await _pokemonRepository.getPokemonById(i));
    }

    setPageState(SUCCESS);
    notifyListeners();
  }
}
