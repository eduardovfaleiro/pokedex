// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:pokedex/common/datasources/local/models/hive_pokemon_image_url.dart';

import 'hive_pokemon_stats.dart';

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
  final List<HivePokemonImageUrl> images;
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
    required this.images,
    required this.heightDecimeter,
    required this.weightHectogram,
    required this.stats,
  });
}
