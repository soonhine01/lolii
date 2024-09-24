import 'package:flutter/material.dart';

class EnergySavingPage extends StatelessWidget {
  const EnergySavingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enerji Tasarrufu İpuçları'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: EnergySavingContent(),
      ),
    );
  }
}

class EnergySavingContent extends StatelessWidget {
  const EnergySavingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Açıklama Metni
        const Text(
          'Günlük yaşamınızda enerji tasarrufu yapmak, hem çevreye katkıda bulunur hem de faturalarınızı düşürür.',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),

        // Enerji Tasarrufu İpuçları Başlığı
        const Text(
          'İpuçları:',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // İpuçları Listesi
        _buildTip('LED ampuller kullanın.'),
        _buildTip('Cihazları kapatın veya bekleme modunda bırakmayın.'),
        _buildTip('Termostatı optimize edin.'),
        _buildTip('Su tasarruflu armatürler kullanın.'),
        const SizedBox(height: 20),

        // Grafik veya İnfografik
        const Text(
          'Enerji Tasarrufunun Faydaları:',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // Buraya grafik veya infografik eklenebilir
        Image.network('https://example.com/energy-saving-infographic.jpg'), // Örnek bir URL

        const SizedBox(height: 20),

        // Videolar veya Kaynaklar
        const Text(
          'Daha Fazla Bilgi:',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildVideoLink('Enerji Tasarrufu Videoları', 'https://example.com/videos'),

        // Kullanıcı Yorumları
        const SizedBox(height: 20),
        const Text(
          'Kullanıcı Yorumları:',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildComment("Enerji tasarrufu sayesinde ayda 100 TL tasarruf ettim!"),
      ],
    );
  }

  // İpuçları Oluşturma
  static Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text('• $tip', style: const TextStyle(fontSize: 16)),
    );
  }

  // Video Linki Oluşturma
  static Widget _buildVideoLink(String title, String url) {
    return TextButton(
      onPressed: () {
        // Video linkine yönlendirme
      },
      child: Text(title, style: const TextStyle(fontSize: 16, color: Colors.blue)),
    );
  }

  // Kullanıcı Yorumları Oluşturma
  static Widget _buildComment(String comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text('- $comment', style: const TextStyle(fontSize: 16)),
    );
  }
}
