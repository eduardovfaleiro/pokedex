// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pokedex/common/repositories/pokemon_repository.dart';

import '../models/pokemon.dart';

class SearchPokemonViewModel extends ChangeNotifier {
  final PokemonRepository pokemonRepository;

  SearchPokemonViewModel({required this.pokemonRepository});

  final searchController = TextEditingController();
  bool get isSearchingPokemon => searchController.text.isNotEmpty;

  void initialize() {
    searchController.removeListener(() {});
    searchController.clear();

    searchController.addListener(() {
      notifyListeners();
    });
  }

  Future<List<Pokemon>> searchPokemon() async {
    return pokemonRepository.searchPokemon(searchController.text.toLowerCase());
  }
}
