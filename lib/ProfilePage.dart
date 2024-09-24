import 'dart:io'; // File kullanabilmek için
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Profil sayfası
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  XFile? _profileImage;

  @override
  void initState() {
    super.initState();
    // Kullanıcı verilerini başlangıçta doldur
    _nameController.text = 'Vildan'; // Örnek isim
    _emailController.text = 'Vildan@example.com'; // Örnek e-posta
  }

  void _updateProfile() {
    // Güncellenmiş verileri al ve işle
    String updatedName = _nameController.text;
    String updatedEmail = _emailController.text;

    // Verileri kaydetme işlemi burada yapılabilir (örneğin, bir veritabanına)
    print('Güncellenmiş İsim: $updatedName');
    print('Güncellenmiş E-posta: $updatedEmail');

    // Kullanıcıya bilgi ver
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil güncellendi!')),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Profili'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage, // Resme tıklanırsa resmi değiştir
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage == null
                      ? const NetworkImage('https://example.com/profile.jpg')
                      : FileImage(File(_profileImage!.path)) as ImageProvider,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'İsim'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-posta'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('Güncelle'),
            ),
          ],
        ),
      ),
    );
  }
}
