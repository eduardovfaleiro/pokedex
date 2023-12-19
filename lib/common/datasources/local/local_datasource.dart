import 'package:pokedex/common/datasources/local/generated/pokemon.dart';
import 'package:pokedex/common/models/pokemon.dart' as global_models;

abstract class LocalDataSource {
  Future<void> cachePokemon(global_models.Pokemon pokemon);
}

class HiveDataSource implements LocalDataSource {
  @override
  Future<void> cachePokemon(global_models.Pokemon pokemon) async {
    await pokemon.save();
  }
}
