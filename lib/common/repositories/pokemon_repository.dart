import 'package:http/http.dart' as http;
import 'package:pokedex/common/datasources/local/local_pokemon_datasource.dart';

import '../models/pokemon.dart';

abstract class IPokemonRepository {
  Future<Pokemon> getPokemonById(int id);
}

class PokemonRepository implements IPokemonRepository {
  final LocalPokemonDataSource dataSource;

  PokemonRepository(this.dataSource);

  @override
  Future<Pokemon> getPokemonById(int id) async {
    if (await dataSource.existsId(id)) {
      return await dataSource.getId(id);
    }

    var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
    var pokemon = Pokemon.fromJson(response.body);
    await dataSource.cache(pokemon);

    return pokemon;
  }
}
