// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/common/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/common/view_models/pokemon_list_view_model.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/utils/page_state_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/models/pokemon.dart';
import '../../common/repositories/pokemon_repository.dart';

class HomeController {
  final PokemonListViewModel pokemonListViewModel;
  final PokemonArtViewModel pokemonArtViewModel;

  HomeController({required this.pokemonListViewModel, required this.pokemonArtViewModel});

  final scrollController = ScrollController();
  final isLoadingMorePokemon = ValueNotifier(false);

  Future<void> initialize() async {
    await pokemonListViewModel.initialize();
    pokemonArtViewModel.initialize();

    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        bool isBottom = scrollController.position.pixels != 0;

        if (isBottom && !isLoadingMorePokemon.value) {
          isLoadingMorePokemon.value = true;
          await pokemonListViewModel.loadPokemon();
          isLoadingMorePokemon.value = false;
        }
      }
    });
  }

  Future<void> loadPokemon() async {
    await pokemonListViewModel.loadPokemon();
  }

  void switchArt() {
    pokemonArtViewModel.switchArt();
  }
}
