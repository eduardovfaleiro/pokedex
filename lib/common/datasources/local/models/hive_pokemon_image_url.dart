import 'package:hive/hive.dart';

part 'hive_pokemon_image_url.g.dart';

@HiveType(typeId: 2)
class HivePokemonImageUrl extends HiveObject {
  @HiveField(0)
  final String art;
  @HiveField(1)
  final String url;

  HivePokemonImageUrl(this.url, {required this.art});
}
