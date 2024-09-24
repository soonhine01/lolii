import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loli/main.dart'; // Proje yolunuza göre güncelleyin

void main() {
  testWidgets('Ana sayfa doğru yükleniyor mu?', (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const MyApp());

    // Ana sayfa başlığını kontrol et
    expect(find.text('Loli'), findsOneWidget);

    // Arama ikonunun varlığını kontrol et
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Profil ve Mesajlaşma butonlarını kontrol et
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.message), findsOneWidget);

    // Ana sayfada kartların başlıklarını kontrol et
    expect(find.text('Enerji Tasarrufu'), findsOneWidget);
    expect(find.text('Atık Yönetimi'), findsOneWidget);
    expect(find.text('Doğada Yürüyüş'), findsOneWidget);
    expect(find.text('Koşma'), findsOneWidget);
    expect(find.text('Bisiklet Sürme'), findsOneWidget);
  });

  testWidgets('Profil butonuna tıklama', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Profil butonuna tıkla
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Profil sayfasına yönlendirme yapılacağını kontrol edin
    // Bu testi yönlendirme ekleyince özelleştirebilirsiniz.
    // Örneğin: expect(find.text('Profil Sayfası'), findsOneWidget);
  });

  testWidgets('Mesajlaşma butonuna tıklama', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Mesajlaşma butonuna tıkla
    await tester.tap(find.byIcon(Icons.message));
    await tester.pumpAndSettle();

    // Mesajlaşma sayfasına yönlendirme yapılacağını kontrol edin
    // Bu testi yönlendirme ekleyince özelleştirebilirsiniz.
    // Örneğin: expect(find.text('Sohbet Sayfası'), findsOneWidget);
  });

  testWidgets('FloatingActionButton\'a tıklama', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // FloatingActionButton butonuna tıkla
    await tester.tap(find.byIcon(Icons.eco));
    await tester.pumpAndSettle();

    // Karbon ayak izi sayfasına yönlendirme yapılacağını kontrol edin
    // Bu testi yönlendirme ekleyince özelleştirebilirsiniz.
    // Örneğin: expect(find.text('Karbon Ayak İzi Sayfası'), findsOneWidget);
  });

  testWidgets('Kartlara tıklama', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Enerji Tasarrufu kartına tıkla
    await tester.tap(find.text('Enerji Tasarrufu'));
    await tester.pumpAndSettle();

    // Kart tıklama sonrası yapılacak işlemi kontrol edin
    // Bu testi yönlendirme ekleyince özelleştirebilirsiniz.
  });
}
