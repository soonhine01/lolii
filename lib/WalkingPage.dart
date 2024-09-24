import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkingActivityPage extends StatefulWidget {
  const WalkingActivityPage({super.key});

  @override
  _WalkingActivityPageState createState() => _WalkingActivityPageState();
}

class _WalkingActivityPageState extends State<WalkingActivityPage> {
  int _stepCount = 0;
  double _distance = 0.0;
  double _caloriesBurned = 0.0;
  Position? _lastPosition;
  StreamSubscription<Position>? _positionSubscription;

  // Adım başına ortalama mesafe (metre)
  final double _averageStepLength = 0.78; // Ortalama adım uzunluğu (0.78 m)

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

    // Konum güncellemeleri için dinleyici oluştur
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1, // Her adımda güncelleme
    );

    _positionSubscription = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      setState(() {
        _updateStepCountAndDistance(position);
        _saveData();
      });
    });
  }

  // Adım sayısını ve mesafeyi güncelle
  void _updateStepCountAndDistance(Position position) {
    if (_lastPosition != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        _lastPosition!.latitude,
        _lastPosition!.longitude,
        position.latitude,
        position.longitude,
      );

      if (distanceInMeters > 1) { // 1 metreyi geçtiyse
        _stepCount++;
        _distance += _averageStepLength / 1000; // km'ye dönüştür
        _caloriesBurned = _calculateCaloriesBurned(_stepCount);
      }
    }
    _lastPosition = position;
  }

  // Yakılan kalori hesaplama
  double _calculateCaloriesBurned(int steps) {
    // Kalori hesabı için ortalama bir formül: Adım sayısı * adım başına kalori (ortalama 0.04 kalori/adım)
    return steps * 0.04; // Kalori değeri
  }

  // Verileri yerel depolamaya kaydet
  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('stepCount', _stepCount);
    await prefs.setDouble('distance', _distance);
    await prefs.setDouble('calories', _caloriesBurned);
  }

  // Yerel depolamadan verileri yükle
  void _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _stepCount = prefs.getInt('stepCount') ?? 0;
      _distance = prefs.getDouble('distance') ?? 0.0;
      _caloriesBurned = prefs.getDouble('calories') ?? 0.0;
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
        title: const Text('Walking Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Adım Sayısı: $_stepCount',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              'Mesafe: ${_distance.toStringAsFixed(2)} km',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              'Yakılan Kalori: ${_caloriesBurned.toStringAsFixed(2)} kcal',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            // (İsteğe bağlı olarak) Mesafe grafik verilerini ekleyebilirsiniz.
          ],
        ),
      ),
    );
  }
}
