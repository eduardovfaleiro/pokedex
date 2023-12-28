// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/common/view_models/search_pokemon_view_model.dart';

import '../../common/models/pokemon.dart';
import '../../common/utils/const/pokemon_art.dart';

class HomeController {
  final PokemonRepository pokemonRepository;
  final PokemonArtViewModel pokemonArtViewModel;
  final SearchPokemonViewModel searchPokemonViewModel;

  HomeController({
    required this.pokemonRepository,
    required this.pokemonArtViewModel,
    required this.searchPokemonViewModel,
  });

  final scrollController = ScrollController();
  final isLoadingMorePokemon = ValueNotifier(false);

  Future<void> initialize() async {
    searchPokemonViewModel.initialize();
    pokemonArtViewModel.initialize();

    scrollController.removeListener(() {});

    int hitBottomCount = 0;

    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        bool isBottom = scrollController.position.pixels != 0;

        if (isBottom) {
          hitBottomCount++;

          if (hitBottomCount >= 3) {
            isLoadingMorePokemon.value = true;
            await Future.delayed(const Duration(seconds: 2));
            isLoadingMorePokemon.value = false;
          }
        }
      }
    });
  }

  Future<Pokemon> getPokemonId(int pokemonId, {required PokemonArt art}) {
    return pokemonRepository.getPokemonId(pokemonId, art: art);
  }

  Future<List<int>> searchPokemon() async {
    return searchPokemonViewModel.searchPokemon();
  }

  void switchArt() {
    pokemonArtViewModel.switchArt();
  }

  Future<Uint8List> getPokemonImage(int id, String imageUrl) {
    return pokemonRepository.getPokemonImage(id, imageUrl, pokemonArt: pokemonArtViewModel.pokemonArt);
  }
}
