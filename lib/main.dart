import 'package:flutter/material.dart';
import 'package:pokedex/common/datasources/local/local_pokemon_object_datasource.dart';
import 'package:pokedex/common/utils/hive_manager.dart';
import 'package:pokedex/common/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/common/view_models/search_pokemon_view_model.dart';
import 'package:pokedex/features/controllers/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/repositories/pokemon_repository.dart';
import 'features/pages/home_page.dart';
import 'common/utils/const/shared_preferences_instance.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  await HiveManager.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PokemonArtViewModel()),
        ChangeNotifierProvider(
          create: (context) => SearchPokemonViewModel(
            pokemonRepository: PokemonRepository(HivePokemonObjectDataSource()),
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
