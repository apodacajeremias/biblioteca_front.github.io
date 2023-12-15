import 'package:biblioteca_front/ui/charts/contador_entrada_chart.dart';
import 'package:biblioteca_front/ui/charts/contador_entrada_chart copy.dart'
    as copy;
import 'package:biblioteca_front/ui/charts/flujo_entrada.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Text('Inicio', style: Theme.of(context).textTheme.titleLarge),
        Wrap(
          children: [
            Container(width: size.width / 2, child: ContadorEntradaChart()),
            Container(
                width: size.width / 2, child: copy.ContadorEntradaChart()),
            LineChartSample1()
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
