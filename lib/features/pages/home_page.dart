import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/common/datasources/local/local_pokemon_object_datasource.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/common/view_models/search_pokemon_view_model.dart';
import 'package:pokedex/common/widgets/my_text_field.dart';
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
      pokemonRepository: PokemonRepository(HivePokemonObjectDataSource()),
      pokemonArtViewModel: context.read<PokemonArtViewModel>(),
      searchPokemonViewModel: context.read<SearchPokemonViewModel>(),
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Pokédex',
          style: TextStyle(
            fontFamily: 'Pokemon',
            color: Colors.red,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                tooltip: 'Switch art',
                onPressed: () {
                  _homeController.switchArt();
                },
                icon: const Icon(CupertinoIcons.restart)),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<PokemonArtViewModel>(
          builder: (context, pokemonArtViewModel, _) {
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Scrollbar(
                    child: Consumer<SearchPokemonViewModel>(
                      builder: (context, searchPokemonViewModel, _) {
                        if (searchPokemonViewModel.isSearchingPokemon) {
                          return FutureBuilder(
                            future: _homeController.searchPokemon(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: PokeballLoading());
                              }

                              final searchedPokemon = snapshot.data!;

                              return GridView.builder(
                                controller: _homeController.scrollController,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.35,
                                ),
                                itemCount: searchedPokemon.length,
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height * .1,
                                  top: MediaQuery.of(context).size.height * .085,
                                  left: 6,
                                  right: 6,
                                ),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: PokemonCard(
                                      searchedPokemon[index],
                                      pokemonArt: pokemonArtViewModel.pokemonArt,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }

                        return FutureBuilder(
                          future: _homeController.getPokemonCount(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: PokeballLoading());
                            }

                            final pokemonCount = snapshot.data as int;

                            return GridView.builder(
                              controller: _homeController.scrollController,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.35,
                              ),
                              itemCount: pokemonCount,
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height * .1,
                                top: MediaQuery.of(context).size.height * .085,
                                left: 6,
                                right: 6,
                              ),
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                  future: _homeController.getPokemonId(index + 1),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const PokeballLoading();
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: PokemonCard(
                                        snapshot.data as Pokemon,
                                        pokemonArt: pokemonArtViewModel.pokemonArt,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ValueListenableBuilder(
                    valueListenable: _homeController.isLoadingMorePokemon,
                    builder: (context, isLoadingMorePokemon, _) {
                      return Visibility(
                        visible: isLoadingMorePokemon,
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: const PokeballLoading(),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: MyTextField(
                      controller: _homeController.searchPokemonViewModel.searchController,
                      hintText: 'Search for Pokemon',
                      preffixIcon: Icons.search,
                      showClear: true,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
