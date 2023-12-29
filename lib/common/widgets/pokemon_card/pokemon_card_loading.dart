import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/common/widgets/pokeball_loading.dart';

class PokemonCardLoading extends StatelessWidget {
  const PokemonCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 0,
            offset: Offset.zero,
            color: Color.fromARGB(90, 0, 0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFEEEEEE),
            Color.fromARGB(255, 235, 235, 235),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: const Center(child: PokeballLoading(height: 36, color: Colors.grey)),
    );
  }
}
