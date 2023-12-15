import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/common/services/pokemon_colors_service.dart';

class PokemonTypeImageLoader extends StatelessWidget {
  final double height;
  final String pokemonType;

  const PokemonTypeImageLoader(this.pokemonType, {super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    var typeColor = PokemonColorsService.get(pokemonType);

    switch (pokemonType) {
      case 'normal':
        return Icon(Icons.star_border_purple500, color: typeColor);
      case 'fire':
        return Icon(CommunityMaterialIcons.fire, color: typeColor);
      case 'water':
        return Icon(Icons.water_drop, color: typeColor);
      case 'grass':
        return Icon(Icons.grass, color: typeColor);
      case 'electric':
        return Icon(CommunityMaterialIcons.lightning_bolt, color: typeColor);
      case 'ice':
        return Icon(CommunityMaterialIcons.ice_pop, color: typeColor);
      case 'fighting':
        return Icon(CommunityMaterialIcons.sword_cross, color: typeColor);
      case 'poison':
        return Icon(CommunityMaterialIcons.flask_round_bottom, color: typeColor);
      case 'ground':
        return Icon(CommunityMaterialIcons.earth, color: typeColor);
      case 'flying':
        return Icon(CommunityMaterialIcons.bird, color: typeColor);
      case 'psychic':
        return Icon(CommunityMaterialIcons.brain, color: typeColor);
      case 'bug':
        return Icon(CommunityMaterialIcons.bug, color: typeColor);
      case 'rock':
        return Icon(Icons.star_border_purple500, color: typeColor);
      case 'ghost':
        return Icon(CommunityMaterialIcons.ghost, color: typeColor);
      case 'dark':
        return Icon(CommunityMaterialIcons.moon_full, color: typeColor);
      case 'dragon':
        return Icon(Icons.star_border_purple500, color: typeColor);
      case 'steel':
        return Icon(CommunityMaterialIcons.soldering_iron, color: typeColor);
      case 'fairy':
        return Icon(Icons.star_border_purple500, color: typeColor);
      default:
        return Icon(Icons.star_border_purple500, color: typeColor);
    }
  }
}
