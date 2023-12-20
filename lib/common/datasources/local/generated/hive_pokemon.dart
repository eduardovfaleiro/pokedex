// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../services/pokemon_colors_service.dart';
import 'hive_pokemon_stats.dart';
import 'package:pokedex/common/models/pokemon.dart' as g_pokemon;

part 'hive_pokemon.g.dart';

@HiveType(typeId: 0)
class HivePokemon extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<dynamic> types;
  @HiveField(3)
  final Map<String, dynamic> sprite;
  @HiveField(4)
  final int heightDecimeter;
  @HiveField(5)
  final int weightHectogram;
  @HiveField(6)
  final HivePokemonStats stats;

  HivePokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.sprite,
    required this.heightDecimeter,
    required this.weightHectogram,
    required this.stats,
  });

  double get heightCentimeter => heightDecimeter / 10;
  double get weightKg => weightHectogram / 10;

  List<String> get typesStr {
    return List<String>.from(types.map((e) => e['type']['name']));
  }

  factory HivePokemon.fromMap(Map<String, dynamic> map) {
    return HivePokemon(
      id: map['id'] as int,
      name: map['name'] as String,
      types: map['types'] as List<dynamic>,
      sprite: map['sprites'] as Map<String, dynamic>,
      heightDecimeter: map['height'] as int,
      weightHectogram: map['weight'] as int,
      stats: HivePokemonStats(
        health: map['stats'][0]['base_stat'] as int,
        attack: map['stats'][1]['base_stat'] as int,
        defense: map['stats'][2]['base_stat'] as int,
        specialAttack: map['stats'][3]['base_stat'] as int,
        specialDefense: map['stats'][4]['base_stat'] as int,
        speed: map['stats'][5]['base_stat'] as int,
      ),
    );
  }

  factory HivePokemon.fromJson(String source) => HivePokemon.fromMap(json.decode(source) as Map<String, dynamic>);
}
