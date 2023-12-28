import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/common/services/pokemon_colors_service.dart';

class PokemonTypeImageLoader extends StatelessWidget {
  final double height;
  final String pokemonType;
  final Color color;

  const PokemonTypeImageLoader(this.pokemonType, {super.key, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    switch (pokemonType) {
      case 'normal':
        return Icon(Icons.star_border_purple500, color: color);
      case 'fire':
        return Icon(CommunityMaterialIcons.fire, color: color);
      case 'water':
        return Icon(Icons.water_drop, color: color);
      case 'grass':
        return Icon(Icons.grass, color: color);
      case 'electric':
        return Icon(CommunityMaterialIcons.lightning_bolt, color: color);
      case 'ice':
        return Icon(Icons.ac_unit, color: color);
      case 'fighting':
        return Icon(CommunityMaterialIcons.sword_cross, color: color);
      case 'poison':
        return Icon(CommunityMaterialIcons.flask_round_bottom, color: color);
      case 'ground':
        return Icon(CommunityMaterialIcons.earth, color: color);
      case 'flying':
        return Icon(CommunityMaterialIcons.bird, color: color);
      case 'psychic':
        return Icon(CommunityMaterialIcons.brain, color: color);
      case 'bug':
        return Icon(CommunityMaterialIcons.bug, color: color);
      case 'rock':
        return Icon(Icons.star_border_purple500, color: color);
      case 'ghost':
        return Icon(CommunityMaterialIcons.ghost, color: color);
      case 'dark':
        return Icon(CommunityMaterialIcons.moon_full, color: color);
      case 'dragon':
        return Icon(Icons.star_border_purple500, color: color);
      case 'steel':
        return Icon(CommunityMaterialIcons.soldering_iron, color: color);
      case 'fairy':
        return Icon(Icons.star_border_purple500, color: color);
      default:
        return Icon(Icons.star_border_purple500, color: color);
    }
  }
}
