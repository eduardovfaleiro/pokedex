// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

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
  final List<String> imageUrls;
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
    required this.imageUrls,
    required this.heightDecimeter,
    required this.weightHectogram,
    required this.stats,
  });
}
