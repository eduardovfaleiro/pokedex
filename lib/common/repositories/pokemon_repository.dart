import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pokedex/common/datasources/local/local_pokemon_datasource.dart';

import '../models/pokemon.dart';
import '../utils/const/poke_api.dart';

class PokemonRepository {
  final LocalPokemonDataSource dataSource;

  PokemonRepository(this.dataSource);

  Future<Pokemon> getPokemonId(int id) async {
    var localPokemon = await dataSource.getId(id);
    if (localPokemon != null) return localPokemon;

    var response = await http.get(Uri.parse('${PokeApi.pokemon}/$id'));

    var pokemon = Pokemon.fromJson(response.body);
    await dataSource.cache(pokemon);

    return pokemon;
  }

  Future<List<int>> searchPokemon(String args) async {
    final pokemonUrls = await _getPokemonUrlList();

    var filteredPokemonIds = <int>[];

    for (int i = 0; i < pokemonUrls.length; i++) {
      if (pokemonUrls[i]['name']!.contains(args)) {
        filteredPokemonIds.add(int.parse(pokemonUrls[i]['url']!.split('/')[6]));
      }
    }

    return filteredPokemonIds;

    // final pokemonList = <Pokemon>[];

    // for (int i = 0; i < 1025; i++) {
    //   if (pokemonUrlList[i]['name'].contains(args)) {
    //     pokemonList.add(await getPokemonId(i + 1));
    //   }
    // }

    // int maxIndex = pokemonData['count'];
    // int id;

    // for (int i = 1025; i < maxIndex; i++) {
    //   id = 10000 + i - 1024;

    //   if (pokemonUrlList[i]['name'].contains(args)) {
    //     pokemonList.add(await getPokemonId(id));
    //   }
    // }

    // return pokemonList;
  }

  Future<List<Map<dynamic, dynamic>>> _getPokemonUrlList() async {
    var localPokemonUrls = await dataSource.getPokemonUrlList();
    if (localPokemonUrls.isNotEmpty) return localPokemonUrls;

    try {
      var response = await http.get(Uri.parse('${PokeApi.pokemon}/?limit=9999&offset=0'));
      var pokemonUrlList = List<Map<dynamic, dynamic>>.from(jsonDecode(response.body)['results']);

      await dataSource.cachePokemonUrlList(pokemonUrlList);
      return pokemonUrlList;
    } on http.ClientException {
      return [];
    } on SocketException {
      print('');
    } catch (e) {
      print('');
    }

    return [];
  }
}
