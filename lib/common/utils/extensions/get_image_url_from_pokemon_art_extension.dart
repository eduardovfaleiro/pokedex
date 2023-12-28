import '../../models/pokemon.dart';
import '../const/pokemon_art.dart';

extension GetImageUrlFromPokemonArt on Pokemon {
  String getImageUrlFromPokemonArt(PokemonArt pokemonArt) {
    for (var url in imageUrls) {
      if (url == null) continue;
      if (url.contains(pokemonArt.urlName)) return url;
    }

    throw Exception('PokemonArt not found');
  }
}
