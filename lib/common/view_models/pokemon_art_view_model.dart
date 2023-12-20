import 'package:flutter/material.dart';
import 'package:pokedex/common/utils/const/shared_preferences_instance.dart';
import 'package:pokedex/common/utils/page_state_controller.dart';

import '../utils/const/consts.dart';
import '../utils/const/pokemon_art.dart';

class PokemonArtViewModel extends ChangeNotifier with PageStateController {
  late PokemonArt pokemonArt;

  void initialize() {
    String? savedPokemonArt = sharedPreferences.getString('pokemonArt') ?? Consts.defaultPokemonArt.name;

    switch (savedPokemonArt) {
      case 'dreamWorld':
        pokemonArt = PokemonArt.dreamWorld;
        break;
      case 'officialArtwork':
        pokemonArt = PokemonArt.officialArtwork;
        break;
      case 'home':
        pokemonArt = PokemonArt.home;
        break;
      default:
        throw UnimplementedError();
    }
  }

  void switchArt() {
    setPageState(LOADING);

    int currentIndex = PokemonArt.values.indexOf(pokemonArt);

    if (currentIndex == PokemonArt.values.length - 1) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }

    pokemonArt = PokemonArt.values[currentIndex];
    sharedPreferences.setString('pokemonArt', pokemonArt.name);

    setPageState(SUCCESS);
    notifyListeners();
  }
}
