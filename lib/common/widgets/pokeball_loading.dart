import 'package:flutter/material.dart';

class PokeballLoading extends StatelessWidget {
  const PokeballLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: 10,
      duration: const Duration(days: 999),
      child: Image.asset('pokeball.png'),
    );
  }
}
