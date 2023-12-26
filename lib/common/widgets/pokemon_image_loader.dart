// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/common/datasources/local/local_pokemon_datasource.dart';
import 'package:pokedex/common/models/pokemon_image_url.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/widgets/pokeball_loading.dart';

import '../utils/const/pokemon_art.dart';

class PokemonImageLoader extends StatelessWidget {
  final int id;
  final double height;
  final List<PokemonImageUrl> imageUrls;
  final PokemonArt pokemonArt;

  PokemonImageLoader(
    this.id,
    this.imageUrls, {
    super.key,
    required this.pokemonArt,
    required this.height,
  });

  late final String imageUrl;

  Future<Uint8List> _getImage() async {
    final pokemonRepository = PokemonRepository(HivePokemonDataSource());

    int imageUrlsLength = imageUrls.length;

    for (int i = 0; i < imageUrlsLength; i++) {
      if (imageUrls[i].art == pokemonArt.name) {
        imageUrl = imageUrls[i].url;
        return pokemonRepository.getPokemonImage(id, imageUrls[i], pokemonArt: pokemonArt);
      }
    }

    throw Exception('PokemonArt not found.');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const PokeballLoading();
          }

          var image = snapshot.data as Uint8List;

          if (imageUrl.endsWith('.svg')) {
            return SvgPicture.memory(image, height: height);
          }

          return Image.memory(image, height: height);
        });
  }
}
