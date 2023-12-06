import 'package:http/http.dart' as http;

import '../methods_patterns/pokemon_methods.dart';
import '../models/pokemon.dart';

abstract class IPokemonRepository implements PokemonMethods {}

class PokemonRepository implements IPokemonRepository {
  @override
  Future<Pokemon> getPokemonById(int id) async {
    var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

    return Pokemon.fromJson(response.body);
  }
}
