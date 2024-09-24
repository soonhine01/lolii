import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RunningActivityPage extends StatefulWidget {
  const RunningActivityPage({super.key});

  @override
  _RunningActivityPageState createState() => _RunningActivityPageState();
}

class _RunningActivityPageState extends State<RunningActivityPage> {
  double _distance = 0.0;
  final List<FlSpot> _distanceData = [];
  StreamSubscription<Position>? _positionSubscription;
  Position? _lastPosition;

  @override
  void initState() {
    super.initState();
    _startLocationTracking();
    _loadSavedData();
  }

  // Konum takibini başlat
  void _startLocationTracking() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum servislerinin etkin olup olmadığını kontrol et
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return; // Kullanıcıya konum servislerinin etkin olmadığını bildirin
    }

    // Konum izinlerini kontrol et ve isteme
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return; // Kullanıcı izni reddetti
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return; // Kullanıcı izni kalıcı olarak reddetti
    }

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _positionSubscription = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      setState(() {
        // Mesafeyi hesapla
        _distance += _calculateDistance(position);
        _distanceData.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), _distance));
        _saveData();
      });
    });
  }

  // İki konum arasındaki mesafeyi hesapla
  double _calculateDistance(Position position) {
    if (_lastPosition == null) {
      _lastPosition = position;
      return 0.0;
    }

    double distanceInMeters = Geolocator.distanceBetween(
      _lastPosition!.latitude,
      _lastPosition!.longitude,
      position.latitude,
      position.longitude,
    );
    _lastPosition = position;
    return distanceInMeters / 1000; // km'ye dönüştür
  }

  // Verileri yerel depolamaya kaydet
  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('distance', _distance);
  }

  // Yerel depolamadan verileri yükle
  void _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _distance = prefs.getDouble('distance') ?? 0.0;
    });
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Running Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Mesafe: ${_distance.toStringAsFixed(2)} km',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _distanceData,
                      isCurved: true,
                      barWidth: 2,
                      color: Colors.blue,  // 'colors' yerine 'color' parametresi kullanılıyor
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
