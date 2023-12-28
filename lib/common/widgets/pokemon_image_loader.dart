// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/common/models/image_extension.dart';

class PokemonImageLoader extends StatelessWidget {
  final int id;
  final double height;
  final String imageExtension;
  final Uint8List? image;

  PokemonImageLoader(
    this.id,
    this.image, {
    super.key,
    required this.imageExtension,
    required this.height,
  });

  late final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return SvgPicture.asset('assets/images/default_pokemon.svg');
    }

    if (imageExtension == ImageExtension.svg) {
      return SvgPicture.memory(image!, height: height);
    }

    return Image.memory(image!, height: height);
  }
}
