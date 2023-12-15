import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

abstract class IPokemonRepository {
  Future<Pokemon> getPokemonById(int id);
}

class PokemonRepository implements IPokemonRepository {
  @override
  Future<Pokemon> getPokemonById(int id) async {
    var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

    return Pokemon.fromJson(response.body);
  }
}
