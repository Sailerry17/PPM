import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nusa_kas/domain/kas_calculator.dart';
import 'package:nusa_kas/data/repositories/transaksi_repository.dart';
import 'package:nusa_kas/ui/kas/kas_view_model.dart';
import 'package:nusa_kas/ui/kas/tambah_transaksi_screen.dart';

void main() {
  Widget createTestWidget() {
    return ChangeNotifierProvider(
      create: (_) => KasViewModel(TransaksiRepository(), KasCalculator()),
      child: const MaterialApp(
        home: TambahTransaksiScreen(),
      ),
    );
  }

  testWidgets('Render form dengan semua input field dan button', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    expect(find.byKey(const Key('keteranganField')), findsOneWidget);
    expect(find.byKey(const Key('nominalField')), findsOneWidget);
    expect(find.byKey(const Key('jenisDropdown')), findsOneWidget);
    expect(find.byKey(const Key('simpanButton')), findsOneWidget);
  });

  testWidgets('Menampilkan error validasi jika tombol simpan ditekan namun input kosong', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.tap(find.byKey(const Key('simpanButton')));
    await tester.pump();

    expect(find.text('Tidak boleh kosong'), findsNWidgets(2));
  });
}
