import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/common/services/pokemon_colors_service.dart';
import 'package:pokedex/common/utils/extensions/capitalize_extension.dart';

import '../../../common/models/pokemon_with_image.dart';
import '../../controllers/pokemon_info_controller.dart';
import '../../widgets/pokemon_image_loader.dart';
import '../../widgets/pokemon_type_image_loader.dart';
import 'stat_component.dart';

class PokemonInfoPage extends StatefulWidget {
  final PokemonInfoController pokemonInfoController;
  final PokemonWithImage pokemon;
  final String? imageExtension;

  const PokemonInfoPage(this.pokemon, {super.key, required this.pokemonInfoController, required this.imageExtension});

  @override
  State<PokemonInfoPage> createState() => _PokemonInfoPageState();
}

class _PokemonInfoPageState extends State<PokemonInfoPage> {
  late Color _darkerPokemonColor;

  @override
  void initState() {
    super.initState();

    _darkerPokemonColor = Color.lerp(widget.pokemon.color, Colors.black, 0.9)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.lerp(widget.pokemon.color, Colors.white, 0.4),
      appBar: AppBar(forceMaterialTransparency: true),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Color.lerp(widget.pokemon.color, Colors.white, 0.8)!,
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
                      widget.pokemon.id,
                      widget.pokemon.image,
                      defaultColor: Color.lerp(widget.pokemon.color, Colors.white, 0.5)!,
                      imageExtension: widget.imageExtension,
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
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              color: Colors.white,
                              boxShadow: _boxShadow,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildLabelValue('Height', '${widget.pokemon.heightMeter}m'),
                                      const SizedBox(width: 32),
                                      _buildLabelValue('Weight', '${widget.pokemon.weightKg}kg'),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 32),
                                Expanded(
                                  child: Center(
                                    child: Wrap(
                                      spacing: 32,
                                      children: List.generate(widget.pokemon.typesStr.length, (index) {
                                        return _buildLabelIcon(
                                          widget.pokemon.typesStr[index],
                                          typeColor: PokemonColorsService.get(widget.pokemon.typesStr[index]),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: _boxShadow,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StatComponent(
                            icon: Icon(CupertinoIcons.heart_fill, color: Colors.red[800]),
                            label: 'Health',
                            level: widget.pokemon.stats.health,
                            color: Colors.red[800]!,
                          ),
                          StatComponent(
                            icon: Icon(CommunityMaterialIcons.sword, color: Colors.yellow[800]),
                            label: 'Attack',
                            level: widget.pokemon.stats.attack,
                            color: Colors.yellow[800]!,
                          ),
                          StatComponent(
                            icon: Icon(CommunityMaterialIcons.shield_sun, color: Colors.blue[800]!),
                            label: 'Defense',
                            level: widget.pokemon.stats.defense,
                            color: Colors.blue[800]!,
                          ),
                          StatComponent(
                            icon: Icon(CommunityMaterialIcons.weather_windy, color: Colors.green[800]),
                            label: 'Speed',
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

  Widget _buildLabelValue(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(color: _darkerPokemonColor)),
          const SizedBox(width: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value, style: TextStyle(color: _darkerPokemonColor, fontSize: 18, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelIcon(String label, {required Color typeColor}) {
    var darkerPokemonTypeColor = Color.lerp(PokemonColorsService.get(label), Colors.black, 0.6)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        PokemonTypeImageLoader(label, height: 40, color: typeColor),
        const SizedBox(width: 4),
        Text(label.capitalize(), style: TextStyle(color: darkerPokemonTypeColor)),
      ],
    );
  }
}
