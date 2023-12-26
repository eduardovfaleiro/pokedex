// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

class PokemonStats {
  final int health;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  PokemonStats({
    required this.health,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  factory PokemonStats.fromMap(Map<String, dynamic> map) {
    return PokemonStats(
      health: map[0]['base_stat'] as int,
      attack: map[1]['base_stat'] as int,
      defense: map[2]['base_stat'] as int,
      specialAttack: map[3]['base_stat'] as int,
      specialDefense: map[4]['base_stat'] as int,
      speed: map[5]['base_stat'] as int,
    );
  }
}
