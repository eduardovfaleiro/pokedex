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

  final pagingController = PagingController(firstPageKey: 0);

  HomeController({
    required this.pokemonRepository,
    required this.pokemonArtViewModel,
    required this.searchPokemonViewModel,
  });

  Future<void> initialize() async {
    searchPokemonViewModel.initialize();
    pokemonArtViewModel.initialize();

    pagingController.addPageRequestListener((pageKey) async {
      final pokemonRequests = <Future<Pokemon?>>[];

      int maxIndex = pageKey + 16;

      if (maxIndex > searchPokemonViewModel.searchedPokemon.length) {
        maxIndex = searchPokemonViewModel.searchedPokemon.length;
      }

      for (int i = pageKey; i < maxIndex; i++) {
        int id = searchPokemonViewModel.searchedPokemon[i];
        final pokemonRequest = pokemonRepository.getPokemonId(id, art: pokemonArtViewModel.pokemonArt);

        pokemonRequests.add(pokemonRequest);
      }

      final newPokemon = await Future.wait(pokemonRequests)
        ..removeWhere((pokemon) => pokemon == null);

      if (newPokemon.length < 16) {
        pagingController.appendLastPage(newPokemon);
      } else {
        int nextPageKey = pageKey + newPokemon.length;
        pagingController.appendPage(newPokemon, nextPageKey);
      }
    });
  }

  Future<Pokemon?> getPokemonId(int pokemonId, {required PokemonArt art}) {
    return pokemonRepository.getPokemonId(pokemonId, art: art);
  }

  void switchArt() {
    pokemonArtViewModel.switchArt();
  }

  Future<Uint8List?> getPokemonImage(int id, String? imageUrl) {
    return pokemonRepository.getPokemonImage(id, imageUrl, pokemonArt: pokemonArtViewModel.pokemonArt);
  }
}
