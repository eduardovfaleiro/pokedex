import '../models/pokemon.dart';

abstract class PokemonMethods {
  Future<Pokemon> getPokemonById(int id);
}
