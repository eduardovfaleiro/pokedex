// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:pokedex/common/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/common/view_models/pokemon_list_view_model.dart';

class HomeController {
  final PokemonListViewModel pokemonListViewModel;
  final PokemonArtViewModel pokemonArtViewModel;

  HomeController({required this.pokemonListViewModel, required this.pokemonArtViewModel});

  final scrollController = ScrollController();
  final searchController = TextEditingController();
  final isLoadingMorePokemon = ValueNotifier(false);

  Future<void> initialize() async {
    searchController.addListener(() {
      searchPokemon(searchController.text);
    });

    await pokemonListViewModel.initialize();
    pokemonArtViewModel.initialize();

    scrollController.removeListener(() {});

    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        bool isBottom = scrollController.position.pixels != 0;

        if (isBottom && !isLoadingMorePokemon.value) {
          isLoadingMorePokemon.value = true;
          await pokemonListViewModel.loadMorePokemon();
          isLoadingMorePokemon.value = false;
        }
      }
    });
  }

  Future<void> loadMorePokemon() async {
    await pokemonListViewModel.loadMorePokemon();
  }

  void searchPokemon(String args) {
    pokemonListViewModel.searchPokemon(args);
  }

  void switchArt() {
    pokemonArtViewModel.switchArt();
  }
}
