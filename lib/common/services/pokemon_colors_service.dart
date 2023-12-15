import 'package:flutter/material.dart';

class PokemonColorsService {
  static Color get(String type) {
    switch (type) {
      case 'normal':
        return Colors.brown.shade400;
      case 'fire':
        return Colors.red.shade400;
      case 'water':
        return Colors.blue.shade400;
      case 'grass':
        return Colors.green.shade400;
      case 'electric':
        return Colors.amber.shade400;
      case 'ice':
        return Colors.cyanAccent.shade200;
      case 'fighting':
        return Colors.orange.shade400;
      case 'poison':
        return Colors.purple.shade400;
      case 'ground':
        return Colors.orange.shade300;
      case 'flying':
        return Colors.indigo.shade300;
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen.shade400;
      case 'rock':
        return Colors.grey.shade300;
      case 'ghost':
        return Colors.indigo.shade200;
      case 'dark':
        return Colors.brown.shade200;
      case 'dragon':
        return Colors.indigo.shade400;
      case 'steel':
        return Colors.blueGrey.shade300;
      case 'fairy':
        return Colors.pinkAccent.shade200;
      default:
        return Colors.grey.shade300;
    }
  }
}
