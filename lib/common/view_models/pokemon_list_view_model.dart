// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/utils/page_state_controller.dart';

import '../utils/const/pokemon_request_quantity.dart';
import '../models/pokemon.dart';

class PokemonListViewModel extends ChangeNotifier {
  final IPokemonRepository _pokemonRepository;

  PokemonListViewModel(this._pokemonRepository);

  final cachedPokemon = <Pokemon>[];
  var pokemon = <Pokemon>[];

  bool isLoadingInitialize = false;
  bool isLoadingMore = false;

  Future<void> initialize() async {
    cachedPokemon.clear();
    pokemon.clear();

    isLoadingInitialize = true;
    await _loadPokemon();
    isLoadingInitialize = false;

    notifyListeners();
  }

  Future<void> _loadPokemon() async {
    // int cachedPokemonLength = cachedPokemon.length;

    // for (int i = cachedPokemonLength + 1; i < pokemonRequestQuantity + cachedPokemonLength; i++) {
    //   cachedPokemon.add(await _pokemonRepository.getPokemonById(i));
    // }

    // pokemon = [...cachedPokemon];
    pokemon = [];
  }

  Future<void> loadMorePokemon() async {
    isLoadingMore = true;
    await _loadPokemon();
    isLoadingMore = false;

    notifyListeners();
  }

  void searchPokemon(String args) {
    pokemon = List.from(cachedPokemon.where((pokemon) => pokemon.name.toLowerCase().contains(args.toLowerCase())));
    notifyListeners();
  }
}
