import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kantin/main.dart';
import 'package:nusa_kantin/ui/menu/widgets/menu_detail.dart';

/// Mengatur ukuran layar virtual (1 piksel fisik = 1 piksel logis).
void setUkuran(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('HP portrait (400x800): NavigationBar + ListView', (tester) async {
    setUkuran(tester, const Size(400, 800));
    await tester.pumpWidget(const NusaKantinApp());

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(SliverGrid), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tablet medium (700x900): NavigationRail + grid + panel detail',
      (tester) async {
    setUkuran(tester, const Size(700, 900));
    await tester.pumpWidget(const NusaKantinApp());

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byType(SliverGrid), findsOneWidget);
    expect(find.text('Pilih menu untuk melihat detail'), findsOneWidget);
    expect(
      tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
      isFalse,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tablet expanded (1200x800): NavigationRail extended',
      (tester) async {
    setUkuran(tester, const Size(1200, 800));
    await tester.pumpWidget(const NusaKantinApp());

    expect(
      tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
      isTrue,
    );
    expect(find.byType(SliverGrid), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tablet: pilih menu, tambah, lalu total muncul di Pesanan',
      (tester) async {
    setUkuran(tester, const Size(1000, 700));
    await tester.pumpWidget(const NusaKantinApp());

    await tester.tap(find.text('Nasi Goreng Spesial').first);
    await tester.pump();
    expect(find.byType(MenuDetail), findsOneWidget);

    await tester.tap(find.text('Tambah'));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.receipt_long_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Total'), findsOneWidget);
    expect(find.text('Rp 18.000'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('HP landscape (800x360): menu & pesanan tanpa overflow',
      (tester) async {
    setUkuran(tester, const Size(800, 360));
    await tester.pumpWidget(const NusaKantinApp());
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Nasi Goreng Spesial').first);
    await tester.pump();
    await tester.ensureVisible(find.text('Tambah'));
    await tester.tap(find.text('Tambah'));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.receipt_long_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Total'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('HP kecil (320x568) tanpa overflow', (tester) async {
    setUkuran(tester, const Size(320, 568));
    await tester.pumpWidget(const NusaKantinApp());
    expect(tester.takeException(), isNull);

    await tester.tap(find.byIcon(Icons.receipt_long_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada pesanan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Teks 200% di HP: menu, bottom sheet, dan pesanan aman',
      (tester) async {
    setUkuran(tester, const Size(360, 640));
    tester.platformDispatcher.textScaleFactorTestValue = 2.0;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(const NusaKantinApp());
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Nasi Goreng Spesial').first);
    await tester.pumpAndSettle();
    expect(find.byType(MenuDetail), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Teks 200% di tablet: grid & detail tanpa overflow',
      (tester) async {
    setUkuran(tester, const Size(1000, 700));
    tester.platformDispatcher.textScaleFactorTestValue = 2.0;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(const NusaKantinApp());
    await tester.tap(find.text('Nasi Goreng Spesial').first);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
