import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../constants.dart';
import '../charts/contador_entrada_chart.dart';
import '../charts/promedio_entrada_chart.dart';

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Center(
              child: Text('Inicio',
                  style: Theme.of(context).textTheme.titleLarge)),
        ),
        Wrap(
          children: [
            PromedioEntradaChart(),
            ContadorEntradaChart(),
          ],
        )
      ],
    );
  }
}

Color random({double opacity = 1}) {
  return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
      .withOpacity(opacity);
}
