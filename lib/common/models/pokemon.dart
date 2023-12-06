// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/pokemon_colors_service.dart';
import 'pokemon_stats.dart';

class Pokemon {
  final int id;
  final String name;
  final List<dynamic> types;
  final Map<String, dynamic> sprite;
  final int height;
  final int weight;
  final PokemonStats stats;
  late final Color mixedColor;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.sprite,
    required this.height,
    required this.weight,
    required this.stats,
  }) {
    mixedColor = PokemonColorsService.getMixedColor(typesStr);
  }

  List<String> get typesStr {
    return List<String>.from(types.map((e) => e['type']['name']));
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'] as int,
      name: map['name'] as String,
      types: map['types'] as List<dynamic>,
      sprite: map['sprites'] as Map<String, dynamic>,
      height: map['height'] as int,
      weight: map['weight'] as int,
      stats: PokemonStats(
        health: map['stats'][0]['base_stat'] as int,
        attack: map['stats'][1]['base_stat'] as int,
        defense: map['stats'][2]['base_stat'] as int,
        specialAttack: map['stats'][3]['base_stat'] as int,
        specialDefense: map['stats'][4]['base_stat'] as int,
        speed: map['stats'][5]['base_stat'] as int,
      ),
    );
  }

  factory Pokemon.fromJson(String source) => Pokemon.fromMap(json.decode(source) as Map<String, dynamic>);
}
