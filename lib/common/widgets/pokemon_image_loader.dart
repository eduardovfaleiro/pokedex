import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/const/pokemon_art.dart';
import '../models/pokemon.dart';

class PokemonImageLoader extends StatelessWidget {
  final double height;
  final Pokemon pokemon;
  final PokemonArt pokemonArt;

  const PokemonImageLoader(this.pokemon, {super.key, required this.pokemonArt, required this.height});

  String get _source {
    switch (pokemonArt) {
      case PokemonArt.officialArtwork:
        return pokemon.sprite['other']['home']['front_default'];
      case PokemonArt.dreamWorld:
        return pokemon.sprite['other']['dream_world']['front_default'];
      case PokemonArt.home:
        return pokemon.sprite['other']['official-artwork']['front_default'];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_source.endsWith('.svg')) {
      return SvgPicture.network(_source, height: height);
    }

    return Image.network(_source, height: height);
  }
}
