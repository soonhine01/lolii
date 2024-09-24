import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CyclingPage extends StatefulWidget {
  const CyclingPage({super.key});

  @override
  _CyclingPageState createState() => _CyclingPageState();
}

class _CyclingPageState extends State<CyclingPage> {
  double distance = 0.0; // km
  int duration = 0; // dakika
  double calories = 0.0;
  List<FlSpot> dataPoints = []; // Grafik verileri

  void updateMetrics(double newDistance, int newDuration) {
    setState(() {
      distance = newDistance;
      duration = newDuration;
      calories = calculateCalories(distance);
      dataPoints.add(FlSpot(dataPoints.length.toDouble(), calories)); // Grafik verisi ekle
    });
  }

  double calculateCalories(double distance) {
    return distance * 30; // Örnek kalori hesaplama
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bisiklet Sürme Aktivitesi'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mesafe: ${distance.toStringAsFixed(2)} km', style: const TextStyle(fontSize: 18)),
            Text('Süre: $duration dk', style: const TextStyle(fontSize: 18)),
            Text('Kalori: ${calories.toStringAsFixed(2)} kcal', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateMetrics(10.0, 30); // Örnek mesafe ve süre güncellemeleri
              },
              child: const Text('Aktiviteyi Başlat'),
            ),
            const SizedBox(height: 20),
            const Text('Kalori Grafiği', style: TextStyle(fontSize: 18)),
            SizedBox(height: 200, child: buildChart()),
          ],
        ),
      ),
    );
  }

  Widget buildChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        minX: 0,
        maxX: dataPoints.isNotEmpty ? dataPoints.length.toDouble() : 1,
        minY: 0,
        maxY: dataPoints.isNotEmpty ? (calories + 10) : 10,
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints,
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
