import 'package:flutter/material.dart';
import 'package:pokedex/common/services/pokemon_colors_service.dart';
import 'package:pokedex/common/view_models/pokemon_art_view_model.dart';
import 'package:pokedex/features/controllers/pokemon_info_controller.dart';
import 'package:pokedex/features/pages/pokemon_info_page.dart';
import 'package:pokedex/utils/capitalize_extension.dart';
import 'package:provider/provider.dart';

import '../../utils/const/pokemon_art.dart';
import '../models/pokemon.dart';
import 'pokemon_image_loader.dart';
import 'pokemon_type_image_loader.dart';

class PokemonCard extends StatelessWidget {
  final PokemonArt pokemonArt;
  final Pokemon pokemon;

  const PokemonCard(this.pokemon, {super.key, required this.pokemonArt});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return PokemonInfoPage(
              pokemon,
              pokemonInfoController: PokemonInfoController(pokemonArtViewModel: context.read<PokemonArtViewModel>()),
            );
          }),
        );
      },
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 0,
              offset: Offset.zero,
              color: Color.fromARGB(90, 0, 0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              pokemon.mixedColor.withOpacity(0.8),
              pokemon.mixedColor.withOpacity(1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 4),
              child: PokemonImageLoader(pokemon, pokemonArt: pokemonArt, height: 75),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pokemon.name.capitalize(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: List.generate(pokemon.typesStr.length, (index) {
                    return PokemonTypeImageLoader(
                      pokemon.typesStr[index],
                      height: 15,
                      color: Color.lerp(pokemon.mixedColor, Colors.white, 0.6)!,
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
