// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../services/pokemon_colors_service.dart';
import 'pokemon.dart';
import 'pokemon_stats.dart';

class PokemonWithImage extends Pokemon {
  final Uint8List? image;

  PokemonWithImage({
    required super.id,
    required super.name,
    required super.types,
    required super.heightDecimeter,
    required super.weightHectogram,
    required super.stats,
    required this.image,
    required super.imageUrls,
  });

  @override
  Color get color => PokemonColorsService.get(typesStr.first);
  @override
  double get heightCentimeter => heightDecimeter / 10;
  @override
  double get weightKg => weightHectogram / 10;

  @override
  List<String> get typesStr {
    return List<String>.from(types.map((e) => e['type']['name']));
  }

  factory PokemonWithImage.fromPokemonAndImage(Pokemon pokemon, Uint8List? image) {
    return PokemonWithImage(
      id: pokemon.id,
      name: pokemon.name,
      types: pokemon.types,
      image: image,
      heightDecimeter: pokemon.heightDecimeter,
      weightHectogram: pokemon.weightHectogram,
      stats: pokemon.stats,
      imageUrls: pokemon.imageUrls,
    );
  }
}
