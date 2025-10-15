import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

final HelpersServices helpers = HelpersServices();

class HelpersServices {
  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse('0x$hex'));
  }

  // Bar Chart Data
  List<BarChartGroupData> barChartData(List<dynamic> bars) {
    List<BarChartGroupData> result = [];

    for (int i = 0; i < bars.length; i++) {
      var bar = bars[i];
      double y = bar['sales'];

      result.add(showGroupData(i, y));
    }

    return result;
  }

  // Bar Chart Group Data
  BarChartGroupData showGroupData(int x, double y) {
    return BarChartGroupData(
      barsSpace: 5,
      x: x,
      barRods: [BarChartRodData(toY: y, color: Colors.blue, width: 10)],
    );
  }

  // Spots Data
  List<FlSpot> spotsData(List<dynamic> spots) {
    List<FlSpot> result = [];

    for (int i = 0; i < spots.length; i++) {
      var spot = spots[i];
      double x = i.toDouble();
      double y = spot['value'];

      result.add(FlSpot(x, y));
    }

    return result;
  }

  // Show Axis Title
  FlTitlesData showAxisTitle(String metric, String unit, String title) {
    return FlTitlesData(
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        axisNameWidget: Text('$metric in ($unit)'),
        sideTitles: SideTitles(
          showTitles: true,
          interval: 20,
          reservedSize: 40,
        ),
      ),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        axisNameWidget: Text(title),
        axisNameSize: 30,
        sideTitles: chartBottomTitle(),
      ),
    );
  }

  // Chart Bottom Titles
  SideTitles chartBottomTitle() {
    const Map<int, String> months = <int, String>{
      0: 'Jan',
      1: 'Feb',
      2: 'Mac',
      3: 'Apr',
      4: 'May',
      5: 'Jun',
      6: 'July',
      7: 'Aug',
      8: 'Sep',
      9: 'Oct',
      10: 'Nov',
      11: 'Dec',
    };

    return SideTitles(
      showTitles: true,
      interval: 1,
      getTitlesWidget: (double value, TitleMeta meta) {
        return SideTitleWidget(
          meta: meta,
          space: 5,
          child: Text(
            months[value.toInt()] ?? '',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
