import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nusa_kas/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Tambah 2 transaksi (pemasukan 10000, pengeluaran 5000), periksa saldo', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // 1. Tambah Pemasukan
    await tester.tap(find.byKey(const Key('fabTambah')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('keteranganField')), 'Iuran Anggota');
    await tester.enterText(find.byKey(const Key('nominalField')), '10000');
    await tester.tap(find.byKey(const Key('simpanButton')));
    await tester.pumpAndSettle();

    // 2. Tambah Pengeluaran
    await tester.tap(find.byKey(const Key('fabTambah')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('keteranganField')), 'Beli Konsumsi');
    await tester.enterText(find.byKey(const Key('nominalField')), '5000');

    await tester.tap(find.byKey(const Key('jenisDropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('pengeluaran').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('simpanButton')));
    await tester.pumpAndSettle();

    // 3. Verifikasi Saldo
    expect(find.text('Saldo: Rp 5000.0'), findsOneWidget);
  });
}
