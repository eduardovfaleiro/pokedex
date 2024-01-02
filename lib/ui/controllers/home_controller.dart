// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/utils/extensions/get_image_url_from_pokemon_art_extension.dart';
import 'package:pokedex/common/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/common/view_models/search_pokemon_view_model.dart';

import '../../common/models/pokemon.dart';
import '../../common/models/pokemon_with_image.dart';
import '../../common/utils/const/pokemon_art.dart';

class HomeController {
  final PokemonRepository pokemonRepository;
  final PokemonArtViewModel pokemonArtViewModel;
  final SearchPokemonViewModel searchPokemonViewModel;

  final pagingController = PagingController<int, PokemonWithImage>(firstPageKey: 0);

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
      final pokemonImageRequests = <Future<Uint8List?>>[];
      final pokemonArt = pokemonArtViewModel.pokemonArt;

      int maxIndex = pageKey + 16;

      if (maxIndex > searchPokemonViewModel.searchedPokemon.length) {
        maxIndex = searchPokemonViewModel.searchedPokemon.length;
      }

      for (int i = pageKey; i < maxIndex; i++) {
        int id = searchPokemonViewModel.searchedPokemon[i];
        final pokemonRequest = pokemonRepository.getPokemonId(id, art: pokemonArt);

        pokemonRequests.add(pokemonRequest);
      }

      final newPokemon = await Future.wait(pokemonRequests)
        ..removeWhere((pokemon) => pokemon == null);

      for (int i = 0; i < newPokemon.length; i++) {
        final pokemon = newPokemon[i] as Pokemon;

        pokemonImageRequests.add(
          pokemonRepository.getPokemonImage(
            pokemon.id,
            pokemon.getImageUrlFromPokemonArt(pokemonArt),
            pokemonArt: pokemonArt,
          ),
        );
      }

      final newPokemonImages = await Future.wait(pokemonImageRequests);

      List<PokemonWithImage> newPokemonWithImage = [];

      for (int i = 0; i < newPokemon.length; i++) {
        newPokemonWithImage.add(
          PokemonWithImage.fromPokemonAndImage(
            newPokemon[i] as Pokemon,
            newPokemonImages[i],
          ),
        );
      }

      if (newPokemon.length < 16) {
        pagingController.appendLastPage(newPokemonWithImage);
      } else {
        int nextPageKey = pageKey + newPokemon.length;
        pagingController.appendPage(newPokemonWithImage, nextPageKey);
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
