import 'package:flutter/material.dart';
import 'package:pokedex/common/datasources/local_pokemon/local_pokemon_datasource.dart';
import 'package:pokedex/common/services/hive_service.dart';
import 'package:pokedex/ui/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/ui/view_models/search_pokemon_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/repositories/pokemon_repository.dart';
import 'common/utils/const/shared_preferences_instance.dart';
import 'ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  await HiveService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PokemonArtViewModel()),
        ChangeNotifierProvider(
          create: (context) => SearchPokemonViewModel(
            pokemonRepository: PokemonRepository(HivePokemonDataSource()),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(centerTitle: true),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
