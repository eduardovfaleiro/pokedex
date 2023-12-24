import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/const/consts.dart';
import '../utils/const/pokemon_art.dart';
import '../models/pokemon.dart';

class PokemonImageLoader extends StatelessWidget {
  final double height;
  final Map<String, dynamic> pokemonSprite;
  final PokemonArt pokemonArt;

  const PokemonImageLoader(this.pokemonSprite, {super.key, required this.pokemonArt, required this.height});

  String get _source {
    switch (pokemonArt) {
      case PokemonArt.home:
        return pokemonSprite['other']['home']['front_default'] ??
            pokemonSprite['other']['official-artwork']['front_default'];
      case PokemonArt.dreamWorld:
        return pokemonSprite['other']['dream_world']['front_default'] ??
            pokemonSprite['other']['official-artwork']['front_default'];
      case PokemonArt.officialArtwork:
        return pokemonSprite['other']['official-artwork']['front_default'];
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
