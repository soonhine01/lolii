import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/profile': (context) => const ProfilePage(),
        '/chat': (context) => const ChatPage(),
        '/energySaving': (context) => const EnergySavingPage(),
        '/wasteManagement': (context) => const WasteManagementPage(),
        '/walking': (context) => const WalkingPage(),
        '/running': (context) => const RunningPage(),
        '/cycling': (context) => const CyclingPage(),
        '/carbonFootprint': (context) => const CarbonFootprintPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Loli',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Arama butonu işlevi
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildCard(context, 'Profil', Icons.person, '/profile'),
          _buildCard(context, 'Mesajlar', Icons.message, '/chat'),
          _buildCard(context, 'Enerji Tasarrufu', Icons.lightbulb_outline, '/energySaving'),
          _buildCard(context, 'Atık Yönetimi', Icons.recycling, '/wasteManagement'),
          _buildCard(context, 'Doğada Yürüyüş', Icons.directions_walk, '/walking'),
          _buildCard(context, 'Koşma', Icons.directions_run, '/running'),
          _buildCard(context, 'Bisiklet Sürme', Icons.directions_bike, '/cycling'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/carbonFootprint');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.eco, color: Colors.white),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String routeName) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.green, size: 40),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Her sayfa için doğru routeName ile yönlendirme yapılıyor
          if (title == 'Profil') {
            Navigator.pushNamed(context, '/profile');
          } else if (title == 'Mesajlar') {
            Navigator.pushNamed(context, '/chat');
          } else if (title == 'Enerji Tasarrufu') {
            Navigator.pushNamed(context, '/energySaving');
          } else if (title == 'Atık Yönetimi') {
            Navigator.pushNamed(context, '/wasteManagement');
          } else if (title == 'Doğada Yürüyüş') {
            Navigator.pushNamed(context, '/walking');
          } else if (title == 'Koşma') {
            Navigator.pushNamed(context, '/running');
          } else if (title == 'Bisiklet Sürme') {
            Navigator.pushNamed(context, '/cycling');
          }
        },
      ),
    );
  }
}

// Profil sayfası
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilim'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Profil Bilgileri'),
      ),
    );
  }
}

// Mesajlar sayfası
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesajlarım'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Mesajlar Görüntüleniyor'),
      ),
    );
  }
}

// Enerji Tasarrufu sayfası
class EnergySavingPage extends StatelessWidget {
  const EnergySavingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enerji Tasarrufu'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Enerji Tasarrufu Bilgileri'),
      ),
    );
  }
}

// Atık Yönetimi sayfası
class WasteManagementPage extends StatelessWidget {
  const WasteManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atık Yönetimi'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Atık Yönetimi Bilgileri'),
      ),
    );
  }
}

// Doğada Yürüyüş sayfası
class WalkingPage extends StatelessWidget {
  const WalkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doğada Yürüyüş'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Yürüyüş Aktivitesi'),
      ),
    );
  }
}

// Koşma sayfası
class RunningPage extends StatelessWidget {
  const RunningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koşma'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Koşma Aktivitesi'),
      ),
    );
  }
}

// Bisiklet Sürme sayfası
class CyclingPage extends StatelessWidget {
  const CyclingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bisiklet Sürme'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Bisiklet Sürme Aktivitesi'),
      ),
    );
  }
}

// Karbon Ayak İzi sayfası
class CarbonFootprintPage extends StatelessWidget {
  const CarbonFootprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karbon Ayak İzi Hesaplayıcı'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Karbon Ayak İzi Bilgileri'),
      ),
    );
  }
}
