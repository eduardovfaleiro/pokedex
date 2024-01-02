import 'package:flutter/material.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/utils/const/shared_preferences_instance.dart';

import '../../common/utils/const/consts.dart';
import '../../common/utils/const/pokemon_art.dart';

class PokemonArtViewModel extends ChangeNotifier {
  final PokemonRepository pokemonRepository;
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
    int currentIndex = PokemonArt.values.indexOf(pokemonArt);

    if (currentIndex == PokemonArt.values.length - 1) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }

    pokemonArt = PokemonArt.values[currentIndex];
    sharedPreferences.setString('pokemonArt', pokemonArt.name);

    notifyListeners();
  }
}
