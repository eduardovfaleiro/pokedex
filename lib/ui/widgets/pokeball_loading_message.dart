import 'package:flutter/cupertino.dart';

import 'pokeball_loading.dart';

class PokeballLoadingMessage extends StatelessWidget {
  final String message;

  const PokeballLoadingMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          const PokeballLoading(),
          const SizedBox(height: 12),
          Text(message),
        ]),
      ),
    );
  }
}
