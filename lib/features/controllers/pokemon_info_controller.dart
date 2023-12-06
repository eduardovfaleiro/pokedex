import 'package:pokedex/utils/const/pokemon_art.dart';

import '../../common/view_models/pokemon_art_view_model.dart';

class PokemonInfoController {
  final PokemonArtViewModel pokemonArtViewModel;

  PokemonInfoController({required this.pokemonArtViewModel});

  PokemonArt getPokemonArt() {
    return pokemonArtViewModel.pokemonArt;
  }
}
