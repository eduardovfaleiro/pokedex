import 'package:flutter/material.dart';
import 'package:pokedex/common/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/common/view_models/pokemon_list_view_model.dart';
import 'package:provider/provider.dart';

import '../../common/models/pokemon.dart';
import '../../common/widgets/pokemon_card.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  final HomeController homeController;

  const HomePage(this.homeController, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    widget.homeController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        actions: [
          IconButton(
            onPressed: () {
              widget.homeController.switchArt();
            },
            icon: const Icon(Icons.change_circle),
          ),
        ],
      ),
      body: Consumer<PokemonArtViewModel>(
        builder: (context, pokemonArtViewModel, _) {
          return Consumer<PokemonListViewModel>(
            builder: (context, pokemonListViewModel, _) {
              if (pokemonListViewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (pokemonListViewModel.isOnError) {
                return const Center(child: Text('Something went wrong'));
              }

              var cachedPokemon = pokemonListViewModel.cachedPokemon;

              return ListView.builder(
                controller: widget.homeController.scrollController,
                itemCount: cachedPokemon.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: PokemonCard(cachedPokemon[index], pokemonArt: pokemonArtViewModel.pokemonArt),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
