import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:pokedex/common/datasources/local/local_pokemon_datasource.dart';
import 'package:pokedex/common/models/pokemon_image_url.dart';

import '../models/pokemon.dart';
import '../utils/const/poke_api.dart';
import '../utils/const/pokemon_art.dart';

class PokemonRepository {
  final LocalPokemonDataSource dataSource;

  PokemonRepository(this.dataSource);

  Future<Pokemon> getPokemonId(int id, {required PokemonArt art}) async {
    var localPokemon = await dataSource.getId(id);
    if (localPokemon != null) return localPokemon;

    var response = await http.get(Uri.parse('${PokeApi.pokemon}/$id'));
    var json = jsonDecode(response.body) as Map<String, dynamic>;

    var pokemon = Pokemon.fromMap(json);

    for (var imageUrl in pokemon.images) {
      final imageBytes = await _getPokemonImageUrl(imageUrl.url);
      await dataSource.cacheImage(id, imageBytes, pokemonArt: art);
    }

    await dataSource.cache(pokemon);

    return pokemon;
  }

  Future<Uint8List> _getPokemonImageUrl(String url) async {
    var response = await http.get(Uri.parse(url));

    return response.bodyBytes;
  }

  Future<Uint8List> getPokemonImage(int id, PokemonImageUrl imageUrl, {required PokemonArt pokemonArt}) async {
    var localPokemonImage = await dataSource.getImage(id, pokemonArt: pokemonArt);
    if (localPokemonImage != null) return localPokemonImage;

    var imageBytes = await _getPokemonImageUrl(imageUrl.url);
    return imageBytes;
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
  }

  Future<List<Map>> _getPokemonUrlList() async {
    var localPokemonUrls = await dataSource.getPokemonUrlList();
    if (localPokemonUrls.isNotEmpty) return localPokemonUrls;

    try {
      var response = await http.get(Uri.parse('${PokeApi.pokemon}/?limit=9999&offset=0'));
      var pokemonUrlList = List<Map<dynamic, dynamic>>.from(jsonDecode(response.body)['results']);

      await dataSource.cachePokemonUrlList(pokemonUrlList);
      return pokemonUrlList;
    } on http.ClientException {
      return [];
    }
  }
}
