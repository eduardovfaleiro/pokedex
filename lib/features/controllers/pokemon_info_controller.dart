import 'dart:typed_data';

import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/utils/const/pokemon_art.dart';

import '../../common/view_models/pokemon_art_view_model.dart';

class PokemonInfoController {
  final PokemonArtViewModel pokemonArtViewModel;
  final PokemonRepository pokemonRepository;

  PokemonInfoController({required this.pokemonArtViewModel, required this.pokemonRepository});

  PokemonArt getPokemonArt() {
    return pokemonArtViewModel.pokemonArt;
  }

  Future<Uint8List?> getPokemonImage(int id, String imageUrl) {
    return pokemonRepository.getPokemonImage(id, imageUrl, pokemonArt: pokemonArtViewModel.pokemonArt);
  }
}
