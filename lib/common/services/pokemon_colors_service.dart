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

  static String getHexCode(String type) {
    switch (type) {
      case 'normal':
        return '0xFF8D6E63';
      case 'fire':
        return '0xFFEF5350';
      case 'water':
        return '0xFF42A5F5';
      case 'grass':
        return '0xFF66BB6A';
      case 'electric':
        return '0xFFFFCA28';
      case 'ice':
        return '0xFF18FFFF';
      case 'fighting':
        return '0xFFFFA726';
      case 'poison':
        return '0xFFAB47BC';
      case 'ground':
        return '0xFFFFB74D';
      case 'flying':
        return '0xFF7986CB';
      case 'psychic':
        return '0xFFE91E63';
      case 'bug':
        return '0xFF9CCC65';
      case 'rock':
        return '0xFFE0E0E0';
      case 'ghost':
        return '0xFF9FA8DA';
      case 'dark':
        return '0xFFBCAAA4';
      case 'dragon':
        return '0xFF5C6BC0';
      case 'steel':
        return '0xFF90A4AE';
      case 'fairy':
        return '0xFFFF4081';
      default:
        return '0xFFE0E0E0';
    }
  }
}
