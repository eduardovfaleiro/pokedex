import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pokedex/common/datasources/local_pokemon/local_pokemon_datasource.dart';
import 'package:pokedex/common/utils/extensions/get_image_url_from_pokemon_art_extension.dart';

import '../models/pokemon.dart';
import '../utils/const/poke_api.dart';
import '../utils/const/pokemon_art.dart';

class PokemonRepository {
  final LocalPokemonDataSource dataSource;

  PokemonRepository(this.dataSource);

  Future<Pokemon?> getPokemonId(int id, {required PokemonArt art}) async {
    var localPokemon = await dataSource.getId(id);

    if (localPokemon != null) {
      final imageUrl = localPokemon.getImageUrlFromPokemonArt(art);

      var pokemonImage = await dataSource.getImage(id, pokemonArt: art);

      if (pokemonImage == null) {
        await _cacheImage(localPokemon.id, imageUrl, art: art);
      }

      return localPokemon;
    }

    try {
      var response = await http.get(Uri.parse('${PokeApi.pokemon}/$id'));
      var json = jsonDecode(response.body) as Map<String, dynamic>;

      var pokemon = Pokemon.fromMap(json);

      final imageUrl = pokemon.getImageUrlFromPokemonArt(art);
      await _cacheImage(pokemon.id, imageUrl, art: art);

      await dataSource.cache(pokemon);

      return pokemon;
    } on SocketException catch (error) {
      debugPrint('getPokemonId: $error');
      return null;
    }
  }

  Future<void> _cacheImage(int id, String? imageUrl, {required PokemonArt art}) async {
    Uint8List? imageBytes;

    if (imageUrl != null) {
      imageBytes = await _getPokemonImageUrl(imageUrl);
    }

    await dataSource.cacheImage(id, imageBytes, pokemonArt: art);
  }

  Future<Uint8List?> _getPokemonImageUrl(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      return response.bodyBytes;
    } on SocketException catch (error) {
      debugPrint('_getPokemonImageUrl: $error');
      return null;
    } on ClientException catch (error) {
      debugPrint('_getPokemonImageUrl: $error');
      return null;
    }
  }

  Future<Uint8List?> getPokemonImage(int id, String? imageUrl, {required PokemonArt pokemonArt}) async {
    var localPokemonImage = await dataSource.getImage(id, pokemonArt: pokemonArt);
    if (localPokemonImage != null) return localPokemonImage;

    if (imageUrl == null) return null;

    var imageBytes = await _getPokemonImageUrl(imageUrl);
    return imageBytes;
  }

  Future<List<int>> searchPokemon(String args) async {
    final pokemonUrls = await _getPokemonUrlList();

    var filteredPokemonIds = <int>[];

    if (args.isEmpty) {
      for (int i = 0; i < pokemonUrls.length; i++) {
        filteredPokemonIds.add(_getIdFromUrl(pokemonUrls[i]['url']!));
      }
    } else {
      for (int i = 0; i < pokemonUrls.length; i++) {
        if (pokemonUrls[i]['name']!.contains(args)) {
          filteredPokemonIds.add(_getIdFromUrl(pokemonUrls[i]['url']!));
        }
      }
    }

    return filteredPokemonIds;
  }

  int _getIdFromUrl(String url) {
    return int.parse(url.split('/')[6]);
  }

  Future<List<Map>> _getPokemonUrlList() async {
    var localPokemonUrls = await dataSource.getPokemonUrlList();
    if (localPokemonUrls.isNotEmpty) return localPokemonUrls;

    try {
      var response = await http.get(Uri.parse('${PokeApi.pokemon}/?limit=9999&offset=0'));
      var pokemonUrlList = List<Map<dynamic, dynamic>>.from(jsonDecode(response.body)['results']);

      if (localPokemonUrls.isEmpty) {
        await dataSource.cachePokemonUrlList(pokemonUrlList);
      }

      return pokemonUrlList;
    } on http.ClientException catch (error) {
      debugPrint('_getPokemonUrlList: $error');
      return [];
    }
  }
}
