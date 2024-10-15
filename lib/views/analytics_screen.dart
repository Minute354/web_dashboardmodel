import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:school_web_app/views/sidebars.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  // Sample data representing yearly growth
  final List<YearlyData> data = [
    YearlyData(year: 2018, students: 150, teachers: 10, classes: 5),
    YearlyData(year: 2019, students: 200, teachers: 12, classes: 6),
    YearlyData(year: 2020, students: 250, teachers: 15, classes: 7),
    YearlyData(year: 2021, students: 300, teachers: 18, classes: 8),
    YearlyData(year: 2022, students: 350, teachers: 20, classes: 9),
    YearlyData(year: 2023, students: 400, teachers: 22, classes: 10),
    YearlyData(year: 2024, students: 450, teachers: 25, classes: 11),
  ];

  // Toggle to switch between different metrics
  String selectedMetric = 'Students';

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(''),
        centerTitle: true,
      ),
      drawer: isSmallScreen ? Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
          if (!isSmallScreen) Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Metric Selection Dropdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select Metric: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        value: selectedMetric,
                        items: <String>['Students', 'Teachers', 'Classes']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedMetric = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Expanded Chart Area
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                String year =
                                    data[value.toInt()].year.toString();
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(year),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: _getYInterval(),
                              getTitlesWidget: (value, meta) {
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(value.toInt().toString()),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.black),
                        ),
                        minX: 0,
                        maxX: (data.length - 1).toDouble(),
                        minY: 0,
                        maxY: _getMaxY(),
                        lineBarsData: [
                          LineChartBarData(
                            spots: _getSpots(),
                            isCurved: true,
                            barWidth: 4,
                            color: Colors.blue,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Data Labels
                  _buildLegend(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Generate data points based on selected metric
  List<FlSpot> _getSpots() {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      YearlyData yearlyData = entry.value;
      double yValue;
      switch (selectedMetric) {
        case 'Teachers':
          yValue = yearlyData.teachers.toDouble();
          break;
        case 'Classes':
          yValue = yearlyData.classes.toDouble();
          break;
        case 'Students':
        default:
          yValue = yearlyData.students.toDouble();
      }
      return FlSpot(index.toDouble(), yValue);
    }).toList();
  }

  // Determine the maximum Y value for the chart
  double _getMaxY() {
    double maxY;
    switch (selectedMetric) {
      case 'Teachers':
        maxY = data
                .map((d) => d.teachers)
                .reduce((a, b) => a > b ? a : b)
                .toDouble() +
            5;
        break;
      case 'Classes':
        maxY = data
                .map((d) => d.classes)
                .reduce((a, b) => a > b ? a : b)
                .toDouble() +
            2;
        break;
      case 'Students':
      default:
        maxY = data
                .map((d) => d.students)
                .reduce((a, b) => a > b ? a : b)
                .toDouble() +
            50;
    }
    return maxY;
  }

  // Determine the interval between Y-axis labels
  double _getYInterval() {
    switch (selectedMetric) {
      case 'Teachers':
        return 5;
      case 'Classes':
        return 2;
      case 'Students':
      default:
        return 50;
    }
  }

  // Build legend for the chart
  Widget _buildLegend() {
    Color lineColor;
    switch (selectedMetric) {
      case 'Teachers':
        lineColor = Colors.green;
        break;
      case 'Classes':
        lineColor = Colors.orange;
        break;
      case 'Students':
      default:
        lineColor = Colors.blue;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.circle, color: lineColor),
        SizedBox(width: 8),
        Text(
          '$selectedMetric Growth',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// Data model for yearly data
class YearlyData {
  final int year;
  final int students;
  final int teachers;
  final int classes;

  YearlyData({
    required this.year,
    required this.students,
    required this.teachers,
    required this.classes,
  });
}
