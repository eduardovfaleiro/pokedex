// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pokedex/common/repositories/pokemon_repository.dart';

class SearchPokemonViewModel extends ChangeNotifier {
  final PokemonRepository pokemonRepository;

  SearchPokemonViewModel({required this.pokemonRepository});

  final searchController = TextEditingController();
  var searchedPokemon = <int>[];

  void initialize() {
    searchController.removeListener(() {});
    searchController.clear();
    searchedPokemon.clear();

    searchController.addListener(() {
      notifyListeners();
    });
  }

  Future<void> searchPokemon() async {
    searchedPokemon = await pokemonRepository.searchPokemon(searchController.text.toLowerCase());
    notifyListeners();
  }
}
