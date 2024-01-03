// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/pokemon_colors_service.dart';
import 'pokemon_stats.dart';

class Pokemon {
  final int id;
  final String name;
  final List<dynamic> types;
  final List<String?> imageUrls;
  final int heightDecimeter;
  final int weightHectogram;
  final PokemonStats stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.imageUrls,
    required this.heightDecimeter,
    required this.weightHectogram,
    required this.stats,
  });

  Color get color => PokemonColorsService.get(typesStr.first);
  double get heightMeter => heightDecimeter / 10;
  double get weightKg => weightHectogram / 10;

  List<String> get typesStr {
    return List<String>.from(types.map((e) => e['type']['name']));
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    final sprites = map['sprites']['other'];

    return Pokemon(
      id: map['id'] as int,
      name: map['name'] as String,
      types: map['types'] as List<dynamic>,
      imageUrls: [
        sprites['dream_world']['front_default'],
        sprites['official-artwork']['front_default'],
        sprites['home']['front_default'],
      ],
      heightDecimeter: map['height'] as int,
      weightHectogram: map['weight'] as int,
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
