// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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

  final pagingController = PagingController(firstPageKey: 0);

  Future<void> initialize() async {
    searchPokemonViewModel.initialize();
    pokemonArtViewModel.initialize();

    pagingController.addPageRequestListener((pageKey) async {
      await searchPokemonViewModel.searchPokemon();

      final newPokemon = <Pokemon>[];
      final maxIndex = pageKey + 16;

      for (int i = pageKey; i < maxIndex; i++) {
        final pokemon = await pokemonRepository.getPokemonId(
          searchPokemonViewModel.searchedPokemon[i],
          art: pokemonArtViewModel.pokemonArt,
        );

        newPokemon.add(pokemon);
      }

      if (newPokemon.length < 16) {
        pagingController.appendLastPage(newPokemon);
      } else {
        int nextPageKey = pageKey + newPokemon.length;
        pagingController.appendPage(newPokemon, nextPageKey);
      }
    });
  }

  Future<Pokemon> getPokemonId(int pokemonId, {required PokemonArt art}) async {
    return pokemonRepository.getPokemonId(pokemonId, art: art);
  }

  void switchArt() {
    pokemonArtViewModel.switchArt();
  }

  Future<Uint8List?> getPokemonImage(int id, String imageUrl) {
    return pokemonRepository.getPokemonImage(id, imageUrl, pokemonArt: pokemonArtViewModel.pokemonArt);
  }
}
