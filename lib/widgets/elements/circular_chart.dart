import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CircularChartWidget extends StatelessWidget {
  final List<CircularData> data;

  const CircularChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: MyCircularChart(data),
      ),
    );
  }
}

class MyCircularChart extends StatelessWidget {
  final List<PieChartSectionData> pieChartData;

  MyCircularChart(List<CircularData> data) : pieChartData = CircularDataToPieChartSectionData.convert(data);

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: pieChartData,
        borderData: FlBorderData(show: false),
        centerSpaceRadius: 0,
        sectionsSpace: 2,
        startDegreeOffset: -90,
      ),
    );
  }
}

class CircularData {
  final String label;
  final double value;
  final Color color;

  CircularData(this.label, this.value, this.color);
}

class CircularDataToPieChartSectionData {
  static List<PieChartSectionData> convert(List<CircularData> data) {
    return data.map((circularData) {
      return PieChartSectionData(
        value: circularData.value,
        // title: '${circularData.label}\n${circularData.value}',
        titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
        color: circularData.color,
        radius: 100,
      );
    }).toList();
  }
}
