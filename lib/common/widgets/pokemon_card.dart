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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: PokemonColorsService.get(pokemon.typesStr.first).withOpacity(0.65),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 4),
                child: PokemonImageLoader(pokemon, pokemonArt: pokemonArt, height: 75),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text('id: ${pokemon.id}'),
                  Text(
                    pokemon.name.capitalize(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
