import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/constant/color.constant.dart';
import 'package:flutter_advanced_2025/app/model/expense.model.dart';
import 'package:flutter_advanced_2025/app/services/helpers.service.dart';
import 'package:flutter_advanced_2025/app/widget/drawer.widget.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    String title = data['title'];
    List chartData = data['data'] ?? [];
    return Card(
      margin: EdgeInsets.fromLTRB(30, 15, 30, 30),
      child: Column(
        children: [
          ChartTitleWidget(title: title),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            height: 300,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                minY: 0, maxY: data['highest']+20,
                barGroups: helpers.barChartData(chartData),
                titlesData: helpers.showAxisTitle(data['metric'], data['unit'], 'Month of the Year')
              )
            ),
          )
        ],
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    String title = data['title'];
    List chartData = data['data'] ?? [];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        children: [
          ChartTitleWidget(title: title),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 300,
            child: LineChart(
              LineChartData(
                minX: 0, maxX: 11, minY: 0, maxY: data['highest']+20,
                lineBarsData: [
                  for (var line in chartData)
                    LineChartBarData(
                      spots: helpers.spotsData(line['points']),
                      isCurved: true,
                      color: helpers.hexToColor(line['color']),
                      barWidth: 2,
                      dotData: FlDotData(show: true)
                    )
                ],
                titlesData: helpers.showAxisTitle(data['metric'], data['unit'], 'Month of the Year')
              )
            ),
          ),
          ChartLegendWidget(chartData: chartData)
        ],
      ),
    );
  }
}

class ChartLegendWidget extends StatelessWidget {
  const ChartLegendWidget({super.key, required this.chartData});
  final List chartData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var chart in chartData)
           Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: helpers.hexToColor(chart['color'])
                  ),
                ),
                SizedBox(width: 10,),
                Text('${chart['name']}', style: TextStyle(fontSize: 12),)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    String title = data['title'];
    List chartData = data['data'] ?? [];
    // final ThemeData theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.fromLTRB(30, 30, 30, 15),
      child: Column(
        children: [
          //Title
          ChartTitleWidget(title: title),
          //Chart data
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 300,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 0,
                // sectionsSpace: 0,
                sections: [
                  for (var pie in chartData)
                    PieChartSectionData(
                      radius: 130,
                      value: pie['percentage'],
                      color: helpers.hexToColor(pie['color']),
                      title: '${pie['percentage']}%',
                      titleStyle: TextStyle(fontSize: 14, color: Colors.white)
                    )
                ]
              )
            ),
          ),
          ChartLegendWidget(chartData: chartData)
        ],
      ),
    );
  }
}

class ChartTitleWidget extends StatelessWidget {
  const ChartTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(title, style: TextStyle(fontSize: 14)),
    );
  }
}

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});
  final Map<String, dynamic> data = expenseData;
  final Map<String, dynamic> lineChartData = profitData;
  final Map<String, dynamic> barChartData = salesData;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kShrineBrown900,
        backgroundColor: kShrinePink100,
        title: Text('Charts and Graphs'),
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PieChartWidget(data: data),
            LineChartWidget(data: lineChartData),
            BarChartWidget(data: barChartData)
          ],
        ),
      ),
    );
  }
}