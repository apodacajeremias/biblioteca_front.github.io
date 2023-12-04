import 'package:biblioteca_front/constants.dart';
import 'package:biblioteca_front/utils/color_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FlujoEntradaChart extends StatefulWidget {
  const FlujoEntradaChart({super.key});

  @override
  State<FlujoEntradaChart> createState() => _FlujoEntradaChartState();
}

class _FlujoEntradaChartState extends State<FlujoEntradaChart> {
  Map<int, int> datos = {0: 11, 1: 13, 2: 15, 3: 17, 4: 19, 5: 21, 6: 23};

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AspectRatio(aspectRatio: 3, child: BarChart(mainBarData())),
    );
  }

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> groups = [];
    datos.forEach((key, value) => groups.add(
        makeGroupData(key, value as double, isTouched: key == touchedIndex)));
    return groups;
  }

  //  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
  //       switch (i) {
  //         case 0:
  //           return makeGroupData(0, 5, isTouched: i == touchedIndex);
  //         case 1:
  //           return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
  //         case 2:
  //           return makeGroupData(2, 5, isTouched: i == touchedIndex);
  //         case 3:
  //           return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
  //         case 4:
  //           return makeGroupData(4, 9, isTouched: i == touchedIndex);
  //         case 5:
  //           return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
  //         case 6:
  //           return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
  //         default:
  //           return throw Error();
  //       }
  //   });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.lighten(),
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Lunes';
                break;
              case 1:
                weekDay = 'Martes';
                break;
              case 2:
                weekDay = 'Miércoles';
                break;
              case 3:
                weekDay = 'Jueves';
                break;
              case 4:
                weekDay = 'Viernes';
                break;
              case 5:
                weekDay = 'Sábado';
                break;
              case 6:
                weekDay = 'Domingo';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY).toString(),
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: defaultPadding * 2,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: defaultPadding * 2,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= Colors.yellow.withOpacity(0.5);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellowAccent : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellowAccent.darken(80))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 25, //TODO: mayor valor + 1
            color: Colors.white.darken().withOpacity(0.3),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = Theme.of(context).textTheme.displaySmall;
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('L', style: style);
        break;
      case 1:
        text = Text('M', style: style);
        break;
      case 2:
        text = Text('X', style: style);
        break;
      case 3:
        text = Text('J', style: style);
        break;
      case 4:
        text = Text('V', style: style);
        break;
      case 5:
        text = Text('S', style: style);
        break;
      case 6:
        text = Text('D', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: defaultPadding,
      child: text,
    );
  }
}
