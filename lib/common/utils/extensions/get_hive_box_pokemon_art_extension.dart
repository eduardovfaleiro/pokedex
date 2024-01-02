import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

import '../const/hive_boxes.dart';
import '../const/pokemon_art.dart';

extension GetHiveBoxFromPokemonArt on PokemonArt {
  Box<Uint8List?> getHiveBox() {
    switch (this) {
      case PokemonArt.officialArtwork:
        return Hive.box<Uint8List?>(HiveBoxes.pokemonImgOfficialArtwork);
      case PokemonArt.dreamWorld:
        return Hive.box<Uint8List?>(HiveBoxes.pokemonImgDreamWorld);
      case PokemonArt.home:
        return Hive.box<Uint8List?>(HiveBoxes.pokemonImgHome);
    }
  }
}
