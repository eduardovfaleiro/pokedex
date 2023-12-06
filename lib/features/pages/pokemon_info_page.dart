import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/common/services/pokemon_colors_service.dart';
import 'package:pokedex/common/widgets/pokemon_image_loader.dart';
import 'package:pokedex/features/controllers/pokemon_info_controller.dart';
import 'package:pokedex/utils/capitalize_extension.dart';
import 'package:pokedex/utils/const/pokemon_max_stat.dart';

import '../../common/models/pokemon.dart';

class PokemonInfoPage extends StatefulWidget {
  final PokemonInfoController pokemonInfoController;
  final Pokemon pokemon;

  const PokemonInfoPage(this.pokemon, {super.key, required this.pokemonInfoController});

  @override
  State<PokemonInfoPage> createState() => _PokemonInfoPageState();
}

class _PokemonInfoPageState extends State<PokemonInfoPage> {
  late Color _darkerPokemonColor;

  @override
  void initState() {
    super.initState();

    _darkerPokemonColor = Color.lerp(widget.pokemon.mixedColor, Colors.black, 0.9)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.lerp(widget.pokemon.mixedColor, Colors.white, 0.4),
      appBar: AppBar(
        title: const Text('Pokemon Info'),
        forceMaterialTransparency: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 125),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Color.lerp(widget.pokemon.mixedColor, Colors.white, 0.8)!,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(180)),
                ),
                child: const Column(
                  children: [],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PokemonImageLoader(
                      widget.pokemon,
                      pokemonArt: widget.pokemonInfoController.getPokemonArt(),
                      height: 160,
                    ),
                    Text(
                      widget.pokemon.name.capitalize(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: _darkerPokemonColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(45),
                                right: Radius.circular(4),
                              ),
                              color: Colors.white,
                              boxShadow: _boxShadow,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                _getLabelValue('Height', '23cm'),
                                const SizedBox(width: 8),
                                _getLabelValue('Weight', '6,9kg'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(45),
                                left: Radius.circular(4),
                              ),
                              color: Colors.white,
                              boxShadow: _boxShadow,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            child: Row(
                              children: [
                                _getLabelValue('Height', '23cm'),
                                const SizedBox(width: 8),
                                _getLabelValue('Weight', '6,9kg'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                        boxShadow: _boxShadow,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _getStats(
                            icon: Icon(CupertinoIcons.heart_fill, color: Colors.red[800]),
                            label: 'HP',
                            level: widget.pokemon.stats.health,
                            color: Colors.red[800]!,
                          ),
                          _getStats(
                            icon: Icon(CommunityMaterialIcons.sword, color: Colors.yellow[800]),
                            label: 'ATK',
                            level: widget.pokemon.stats.attack,
                            color: Colors.yellow[800]!,
                          ),
                          _getStats(
                            icon: Icon(CommunityMaterialIcons.shield_sun, color: Colors.blue[800]!),
                            label: 'DEF',
                            level: widget.pokemon.stats.defense,
                            color: Colors.blue[800]!,
                          ),
                          _getStats(
                            icon: Icon(CommunityMaterialIcons.weather_windy, color: Colors.green[800]),
                            label: 'SPD',
                            level: widget.pokemon.stats.defense,
                            color: Colors.green[800]!,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _boxShadow = [
    BoxShadow(
      blurRadius: 6,
      blurStyle: BlurStyle.outer,
      spreadRadius: 0,
      color: Color.fromARGB(54, 0, 0, 0),
    ),
  ];

  Widget _getStats({required Icon icon, required String label, required int level, required Color color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              icon,
              const SizedBox(width: 4),
              Text(label, style: TextStyle(color: color)),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: level / pokemonMaxStat,
            backgroundColor: Color.lerp(color, Colors.white, 0.7),
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _getLabelValue(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(color: _darkerPokemonColor)),
        const SizedBox(width: 4),
        Text(value, style: TextStyle(color: _darkerPokemonColor, fontSize: 18, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
