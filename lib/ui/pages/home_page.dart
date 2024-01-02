import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/common/datasources/local_pokemon/local_pokemon_datasource.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/common/utils/extensions/get_image_url_from_pokemon_art_extension.dart';
import 'package:provider/provider.dart';

import '../../common/models/image_extension.dart';
import '../../common/models/pokemon_with_image.dart';
import '../controllers/home_controller.dart';
import '../view_models/pokemon_art_view_model.dart';
import '../view_models/search_pokemon_view_model.dart';
import '../widgets/my_text_field.dart';
import '../widgets/pokeball_loading.dart';
import '../widgets/pokemon_card/pokemon_card.dart';

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
  void dispose() {
    _homeController.pagingController.dispose();
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
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Consumer<SearchPokemonViewModel>(
                builder: (context, searchPokemonViewModel, _) {
                  return FutureBuilder(
                    future: searchPokemonViewModel.searchPokemon(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: PokeballLoading());
                      }

                      _homeController.pagingController.refresh();

                      return Scrollbar(
                        child: Consumer<PokemonArtViewModel>(
                          builder: (context, pokemonArtViewModel, _) {
                            return PagedGridView<int, PokemonWithImage>(
                              pagingController: _homeController.pagingController,
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .085,
                                bottom: 12,
                                left: 6,
                                right: 6,
                              ),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.35,
                              ),
                              showNewPageProgressIndicatorAsGridChild: false,
                              builderDelegate: PagedChildBuilderDelegate(
                                newPageProgressIndicatorBuilder: (context) {
                                  return Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 24),
                                    child: const PokeballLoading(),
                                  );
                                },
                                firstPageProgressIndicatorBuilder: (context) {
                                  return const Center(child: PokeballLoading());
                                },
                                itemBuilder: (context, pokemonWithImage, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: PokemonCard(
                                      pokemonWithImage,
                                      pokemonArt: pokemonArtViewModel.pokemonArt,
                                      imageExtension: ImageExtension.getFromPokemonUrl(
                                        pokemonWithImage.getImageUrlFromPokemonArt(pokemonArtViewModel.pokemonArt),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
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
        ),
      ),
    );
  }
}
