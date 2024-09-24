import 'package:flutter/material.dart';

class CarbonFootprintPage extends StatefulWidget {
  const CarbonFootprintPage({super.key});

  @override
  CarbonFootprintPageState createState() => CarbonFootprintPageState();
}

class CarbonFootprintPageState extends State<CarbonFootprintPage> {
  final _formKey = GlobalKey<FormState>();
  final _mileageController = TextEditingController();
  double _carbonFootprint = 0.0;

  @override
  void dispose() {
    _mileageController.dispose();
    super.dispose();
  }

  void _calculateCarbonFootprint() {
    if (_formKey.currentState?.validate() ?? false) {
      double mileage = double.tryParse(_mileageController.text) ?? 0.0;
      setState(() {
        _carbonFootprint = mileage * 0.2; // Örnek oran
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karbon Ayak İzi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _mileageController,
                    decoration: const InputDecoration(labelText: 'Gidilen Mesafe (km)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen mesafe girin';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Geçerli bir sayı girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _calculateCarbonFootprint,
                    child: const Text('Hesapla'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_carbonFootprint > 0)
              Text(
                'Karbon Ayak İzin: ${_carbonFootprint.toStringAsFixed(2)} kg CO2',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
