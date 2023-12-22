import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/common/datasources/local/local_pokemon_object_datasource.dart';

import '../models/pokemon.dart';
import '../utils/const/poke_api.dart';

class PokemonRepository {
  final LocalPokemonObjectDataSource dataSource;

  PokemonRepository(this.dataSource);

  Future<Pokemon> getPokemonId(int id) async {
    if (await dataSource.existsId(id)) {
      return dataSource.getId(id);
    }

    var response = await http.get(Uri.parse('${PokeApi.pokemon}/$id'));
    var pokemon = Pokemon.fromJson(response.body);
    await dataSource.cache(pokemon);

    return pokemon;
  }

  Future<List<Pokemon>> searchPokemon(String args) async {
    var response = await http.get(Uri.parse('${PokeApi.pokemon}/?limit=9999&offset=0'));

    final pokemonData = Map<String, dynamic>.from(jsonDecode(response.body));
    final pokemonNameUrlList = List<Map<String, dynamic>>.from(pokemonData['results']);

    final pokemonList = <Pokemon>[];

    for (int i = 0; i < 1025; i++) {
      if (pokemonNameUrlList[i]['name'].contains(args)) {
        pokemonList.add(await getPokemonId(i + 1));
      }
    }

    int maxIndex = pokemonData['count'];
    int id;

    for (int i = 1025; i < maxIndex; i++) {
      id = 10000 + i - 1024;

      if (pokemonNameUrlList[i]['name'].contains(args)) {
        pokemonList.add(await getPokemonId(id));
      }
    }

    return pokemonList;
  }

  Future<int> getPokemonCount() async {
    try {
      var response = await http.get(Uri.parse('${PokeApi.pokemon}/?limit=9999&offset=0'));

      return jsonDecode(response.body)['count'];
    } on http.ClientException {
      return dataSource.getPokemonCount();
    }
  }
}
