import 'package:flutter/material.dart';
import 'package:pokedex/common/repositories/config_repository.dart';

import '../../common/utils/const/pokemon_art.dart';

class PokemonArtViewModel extends ChangeNotifier {
  final ConfigRepository configRepository;
  late PokemonArt pokemonArt;

  PokemonArtViewModel({required this.configRepository});

  Future<void> initialize() async {
    pokemonArt = await configRepository.getPokemonArt();
  }

  Future<void> switchArt() async {
    int currentIndex = PokemonArt.values.indexOf(pokemonArt);

    if (currentIndex == PokemonArt.values.length - 1) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }

    pokemonArt = PokemonArt.values[currentIndex];
    await configRepository.setPokemonArt(pokemonArt);

    notifyListeners();
  }
}
