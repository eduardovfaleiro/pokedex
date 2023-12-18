import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/common/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/common/view_models/pokemon_list_view_model.dart';
import 'package:provider/provider.dart';

import '../../common/models/pokemon.dart';
import '../../common/widgets/pokeball_loading.dart';
import '../../common/widgets/pokemon_card.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _homeController;
  @override
  void initState() {
    super.initState();

    _homeController = HomeController(
      pokemonListViewModel: context.read<PokemonListViewModel>(),
      pokemonArtViewModel: context.read<PokemonArtViewModel>(),
    );

    _homeController.initialize();
  }

  @override
  void dispose() {
    _homeController.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Consumer<PokemonArtViewModel>(
          builder: (context, pokemonArtViewModel, _) {
            return Consumer<PokemonListViewModel>(
              builder: (context, pokemonListViewModel, _) {
                if (pokemonListViewModel.isLoading) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PokeballLoading(),
                        SizedBox(height: 12),
                        Text('Loading your Pokemon...'),
                      ],
                    ),
                  );
                }

                if (pokemonListViewModel.isOnError) {
                  return const Center(child: Text('Something went wrong'));
                }

                var cachedPokemon = pokemonListViewModel.cachedPokemon;

                return ListView(
                  controller: _homeController.scrollController,
                  // crossAxisCount: 2,
                  // childAspectRatio: 1.35,
                  children: [
                    ...List.generate(cachedPokemon.length, (index) {
                      if (index % 2 == 0) return const SizedBox.shrink();

                      return SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            PokemonCard(cachedPokemon[index], pokemonArt: pokemonArtViewModel.pokemonArt),
                            PokemonCard(cachedPokemon[index + 1], pokemonArt: pokemonArtViewModel.pokemonArt),
                          ],
                        ),
                      );
                    }),
                    ValueListenableBuilder(
                      valueListenable: _homeController.isLoadingMorePokemon,
                      builder: (context, isLoadingMorePokemon, _) {
                        return Visibility(
                          visible: isLoadingMorePokemon,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: const PokeballLoading(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
