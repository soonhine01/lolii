import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AtikYonetimiPage extends StatefulWidget {
  const AtikYonetimiPage({super.key});

  @override
  AtikYonetimiPageState createState() => AtikYonetimiPageState();
}

class AtikYonetimiPageState extends State<AtikYonetimiPage> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {}; // Set'i burada final olarak tanımladık
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    try {
      final Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      setState(() {
        markers.add(Marker(
          markerId: const MarkerId('current_location'), // const kullanıldı
          position: LatLng(position.latitude, position.longitude),
        ));
        isLoading = false;
      });
    } catch (e) {
      print('Konum alınamadı: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atık Yönetimi'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Geri Dönüşüm Bilgisi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoCard("Geri dönüşüm nedir?", "Geri dönüşüm, atıkların yeniden işlenerek yeni ürünler haline getirilmesidir."),
            _buildInfoCard("Geri dönüşüm sembolleri", "Malzemelerin geri dönüşümlü olup olmadığını gösterir."),
            const SizedBox(height: 16),
            const Text(
              'Geri Dönüşüm İpuçları',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("1. Tekrar kullanabileceğiniz ürünleri tercih edin."),
            const Text("2. Atıkları ayrı ayrı toplayın."),
            const SizedBox(height: 16),
            const Text(
              'Atık Türleri',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("1. Organik\n2. Plastik\n3. Cam\n4. Metal"),
            const SizedBox(height: 16),
            const Text(
              'Yerel Geri Dönüşüm Noktaları',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Harita Entegrasyonu
            Container(
              height: 200, // Harita yüksekliği
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                markers: markers,
                initialCameraPosition: const CameraPosition( // const kullanıldı
                  target: LatLng(0, 0), // Başlangıç konumu
                  zoom: 10,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Atık Takibi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Aylık atık miktarınızı takip edin."),
            const SizedBox(height: 16),
            const Text(
              'Sosyal Paylaşım',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Sosyal medya paylaşım kodları
              },
              child: const Text('Başarılarımı Paylaş'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Hedef Belirleme',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Kendi geri dönüşüm hedeflerinizi belirleyin."),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}
