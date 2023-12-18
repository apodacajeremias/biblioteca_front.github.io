import 'package:biblioteca_front/app_colors.dart';
import 'package:biblioteca_front/constants.dart';
import 'package:biblioteca_front/providers/entrada_provider.dart';
import 'package:biblioteca_front/utils/color_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/records/contador_entrada.dart';
import '../../responsive.dart';

class _BarChart extends StatelessWidget {
  final List<ContadorEntrada> entradas;
  const _BarChart(this.entradas);

  @override
  Widget build(BuildContext context) {
    double max = 1;
    if (entradas.isNotEmpty) {
      max = entradas
          .map((e) => e.cantidad)
          .reduce((curr, next) => curr > next ? curr : next);
    } else {
      return Center(
          child: Text('No hay datos',
              style: Theme.of(context).textTheme.bodyMedium));
    }
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: max + 10,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: defaultPadding / 2,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.contentColorCyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorBlue.darken(20),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Lu';
        break;
      case 2:
        text = 'Ma';
        break;
      case 3:
        text = 'Mi';
        break;
      case 4:
        text = 'Ju';
        break;
      case 5:
        text = 'Vi';
        break;
      case 6:
        text = 'Sa';
        break;
      case 7:
        text = 'Do';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.contentColorBlue.darken(20),
          AppColors.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => entradas
      .map((e) => BarChartGroupData(
            x: e.diaNumero,
            barRods: [
              BarChartRodData(
                toY: e.cantidad,
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          ))
      .toList();
}

class PromedioEntradaChart extends StatefulWidget {
  const PromedioEntradaChart({super.key});

  @override
  State<StatefulWidget> createState() => PromedioEntradaChartState();
}

class PromedioEntradaChartState extends State<PromedioEntradaChart> {
  @override
  void initState() {
    Provider.of<EntradaProvider>(context, listen: false).promedio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = Responsive.isDesktop(context);
    return SizedBox(
      width: isDesktop ? size.width / 2 : size.width,
      child: Card(
        child: Column(
          children: [
            const SizedBox(
              height: defaultPadding,
            ),
            Text('Promedio de permanencia en minutos última semana',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(
              height: defaultPadding,
            ),
            AspectRatio(
              aspectRatio: 1.6,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: _BarChart(
                    Provider.of<EntradaProvider>(context).promedioEntradas),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
