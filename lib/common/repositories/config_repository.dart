import 'package:pokedex/common/datasources/local_config_datasource.dart';

import '../utils/const/pokemon_art.dart';

class ConfigRepository {
  final LocalConfigDataSource dataSource;

  ConfigRepository(this.dataSource);

  Future<PokemonArt> getPokemonArt() {
    return dataSource.getPokemonArt();
  }

  Future<void> setPokemonArt(PokemonArt pokemonArt) {
    return dataSource.setPokemonArt(pokemonArt);
  }
}
