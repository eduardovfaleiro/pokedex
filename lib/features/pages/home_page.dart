import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/common/datasources/local/local_pokemon_datasource.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/utils/extensions/get_image_url_from_pokemon_art_extension.dart';
import 'package:pokedex/common/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/common/view_models/search_pokemon_view_model.dart';
import 'package:pokedex/common/widgets/my_text_field.dart';
import 'package:pokedex/common/widgets/pokemon_card/pokemon_card_loading.dart';
import 'package:provider/provider.dart';

import '../../common/models/image_extension.dart';
import '../../common/models/pokemon.dart';
import '../../common/widgets/pokeball_loading.dart';
import '../../common/widgets/pokemon_card/pokemon_card.dart';
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
      pokemonRepository: PokemonRepository(
        HivePokemonDataSource(),
      ),
      pokemonArtViewModel: context.read<PokemonArtViewModel>(),
      searchPokemonViewModel: context.read<SearchPokemonViewModel>(),
    );

    _homeController.initialize();
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
                        return PagedGridView(
                          pagingController: _homeController.pagingController,
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * .1,
                            top: MediaQuery.of(context).size.height * .085,
                            left: 6,
                            right: 6,
                          ),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.35,
                          ),
                          builderDelegate: PagedChildBuilderDelegate(
                            itemBuilder: (context, pokemon, index) {
                              final pokemonArt = pokemonArtViewModel.pokemonArt;
                              final imageUrl = (pokemon as Pokemon).getImageUrlFromPokemonArt(pokemonArt);

                              return FutureBuilder(
                                future: _homeController.getPokemonImage(
                                  pokemon.id,
                                  imageUrl,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Container();
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: PokemonCard(
                                      image: snapshot.data as Uint8List,
                                      pokemon,
                                      pokemonArt: pokemonArt,
                                      imageExtension: ImageExtension.getFromPokemonUrl(imageUrl),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                        // }
                      },
                    ),
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
