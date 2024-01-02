import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

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
        return Image.asset('assets/images/poison.png', cacheWidth: 20, color: color);
      case 'ground':
        return Image.asset('assets/images/ground.png', cacheWidth: 20, color: color);
      case 'flying':
        return Image.asset('assets/images/flying.png', cacheWidth: 20, color: color);
      case 'psychic':
        return Image.asset('assets/images/psychic.png', cacheWidth: 20, color: color);
      case 'bug':
        return Image.asset('assets/images/bug.png', cacheWidth: 20, color: color);
      case 'rock':
        return Image.asset('assets/images/rock.png', cacheWidth: 20, color: color);
      case 'ghost':
        return Icon(CommunityMaterialIcons.ghost, color: color);
      case 'dark':
        return Image.asset('assets/images/dark.png', cacheWidth: 20, color: color);
      case 'dragon':
        return Image.asset('assets/images/dragon.png', cacheWidth: 20, color: color);
      case 'steel':
        return Icon(CommunityMaterialIcons.soldering_iron, color: color);
      case 'fairy':
        return Image.asset('assets/images/fairy.png', cacheWidth: 20, color: color);
      default:
        return Icon(Icons.star_border_purple500, color: color);
    }
  }
}
