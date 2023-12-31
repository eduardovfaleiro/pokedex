// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'hive_pokemon_stats.g.dart';

@HiveType(typeId: 1)
class HivePokemonStats extends HiveObject {
  @HiveField(0)
  final int health;
  @HiveField(1)
  final int attack;
  @HiveField(2)
  final int defense;
  @HiveField(3)
  final int specialAttack;
  @HiveField(4)
  final int specialDefense;
  @HiveField(5)
  final int speed;

  HivePokemonStats({
    required this.health,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });
}
