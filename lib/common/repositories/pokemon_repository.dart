import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/common/datasources/local/local_pokemon_datasource.dart';

import '../models/pokemon.dart';

class PokemonRepository {
  final LocalPokemonDataSource dataSource;

  PokemonRepository(this.dataSource);

  Future<Pokemon> getPokemonId(int id) async {
    if (await dataSource.existsId(id)) {
      return await dataSource.getId(id);
    }

    var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

    if (response.body == 'Not Found') {
      print('');
    }

    var pokemon = Pokemon.fromJson(response.body);
    await dataSource.cache(pokemon);

    return pokemon;
  }

  Future<List<Pokemon>> searchPokemon(String args) async {
    var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?limit=9999&offset=0'));

    final pokemonData = Map<String, dynamic>.from(jsonDecode(response.body));
    final pokemonNameUrlList = List<Map<String, dynamic>>.from(pokemonData['results']);

    final pokemonList = <Pokemon>[];

    for (int i = 0; i < 1025; i++) {
      if (pokemonNameUrlList[i]['name'].contains(args)) {
        pokemonList.add(await getPokemonId(i + 1));
      }
    }

    if (pokemonNameUrlList.length > 1024) {
      int maxIndex = pokemonData['count'];

      for (int i = 10001; i <= maxIndex; i++) {
        pokemonList.add(await getPokemonId(i));
      }
    }

    return pokemonList;
  }
}
