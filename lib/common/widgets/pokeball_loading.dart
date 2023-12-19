import 'package:flutter/material.dart';

class PokeballLoading extends StatefulWidget {
  const PokeballLoading({super.key});

  @override
  State<PokeballLoading> createState() => _PokeballLoadingState();
}

class _PokeballLoadingState extends State<PokeballLoading> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOutBack);

    _animationController.forward();

    _animationController.addListener(() async {
      if (!_animationController.isCompleted && !_animationController.isDismissed) return;
      await Future.delayed(const Duration(milliseconds: 1000));

      if (!mounted) return;

      if (_animationController.isCompleted) return _animationController.reverse();
      if (_animationController.isDismissed) return _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _curvedAnimation,
      child: Image.asset('assets/images/pokeball.png', height: 50, color: Colors.red),
    );
  }
}
