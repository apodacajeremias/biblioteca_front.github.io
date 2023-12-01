import 'package:biblioteca_front/ui/charts/flujo_entrada.dart';
import 'package:flutter/material.dart';

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Inicio', style: Theme.of(context).textTheme.titleLarge),
        Wrap(
          children: const [
            Card(
              child: Text(
                  'aaaaaaaaaannnnnnnnnnnnnnnaaaaaaaaaaaaaaaannnnnnnnnnnnnnnaaaaaa'),
            ),
            FlujoEntradaChart()
          ],
        )
      ],
    );
  }
}
