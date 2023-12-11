import 'package:biblioteca_front/ui/charts/contador_entrada_chart.dart';
import 'package:biblioteca_front/ui/charts/flujo_entrada.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Inicio', style: Theme.of(context).textTheme.titleLarge),
        Row(
          children: [
            Expanded(child: ContadorEntradaChart()),
            Expanded(child: LineChartSample1())
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
