enum PokemonArt {
  officialArtwork('official-artwork'),
  dreamWorld('dream-world'),
  home('home');

  const PokemonArt(this.urlName);
  final String urlName;

  factory PokemonArt.name(String name) {
    switch (name) {
      case 'officialArtwork':
        return PokemonArt.officialArtwork;
      case 'dreamWorld':
        return PokemonArt.dreamWorld;
      case 'home':
        return PokemonArt.home;
      default:
        throw UnimplementedError();
    }
  }
}
