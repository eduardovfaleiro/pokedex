import 'package:flutter/material.dart';

import '../../../../common/utils/const/consts.dart';

class StatComponent extends StatefulWidget {
  final Icon icon;
  final String label;
  final int level;
  final Color color;

  const StatComponent({
    super.key,
    required this.icon,
    required this.label,
    required this.level,
    required this.color,
  });

  @override
  State<StatComponent> createState() => _StatComponentState();
}

class _StatComponentState extends State<StatComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(flex: 3, child: widget.icon),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.linearToEaseOut,
              tween: Tween<double>(
                begin: 0,
                end: widget.level.toDouble(),
              ),
              builder: (context, level, _) {
                return Stack(
                  children: [
                    LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(8),
                      minHeight: 16,
                      value: level / Consts.pokemonMaxStat,
                      backgroundColor: Color.lerp(widget.color, Colors.white, 0.9),
                      color: widget.color,
                    ),
                    Opacity(
                      opacity: level / widget.level,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          widget.level >= 48 ? '${widget.level}/${Consts.pokemonMaxStat}' : widget.level.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
