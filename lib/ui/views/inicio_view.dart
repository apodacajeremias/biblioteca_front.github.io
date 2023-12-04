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
        Wrap(
          children: [
            const Card(
              child: Text(
                  'aaaaaaaaaannnnnnnnnnnnnnnaaaaaaaaaaaaaaaannnnnnnnnnnnnnnaaaaaa'),
            ),
            const SizedBox.square(
              dimension: 250,
              child: FlujoEntradaChart(),
            ),
            SizedBox.square(
                dimension: 250,
                child: PieChart(PieChartData(sections: [
                  // Valor de las secciones
                  PieChartSectionData(
                      value: 10, color: random(), showTitle: false, radius: 10),
                  PieChartSectionData(
                      value: 15, color: random(), showTitle: false, radius: 15),
                  PieChartSectionData(
                      value: 20, color: random(), showTitle: false, radius: 20),
                  PieChartSectionData(
                      value: 25, color: random(), showTitle: false, radius: 25),
                  PieChartSectionData(
                      value: 30, color: random(), showTitle: false, radius: 30),
                ]))),
            SizedBox.square(dimension: 250, child: BarChart(BarChartData())),
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
