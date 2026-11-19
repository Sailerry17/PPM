import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kas/domain/kas_calculator.dart';
import 'package:nusa_kas/domain/models/transaksi.dart';

void main() {
  late KasCalculator calculator;

  setUp(() {
    calculator = KasCalculator();
  });

  group('KasCalculator Unit Tests', () {
    test('Saldo dari daftar transaksi kosong harus 0', () {
      expect(calculator.hitungSaldo([]), 0.0);
    });

    test('totalPemasukan menghitung hanya pemasukan', () {
      final list = [
        Transaksi(id: '1', keterangan: 'A', nominal: 100, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now()),
        Transaksi(id: '2', keterangan: 'B', nominal: 50, jenis: JenisTransaksi.pengeluaran, tanggal: DateTime.now()),
      ];
      expect(calculator.totalPemasukan(list), 100.0);
    });

    test('totalPengeluaran menghitung hanya pengeluaran', () {
      final list = [
        Transaksi(id: '1', keterangan: 'A', nominal: 100, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now()),
        Transaksi(id: '2', keterangan: 'B', nominal: 50, jenis: JenisTransaksi.pengeluaran, tanggal: DateTime.now()),
      ];
      expect(calculator.totalPengeluaran(list), 50.0);
    });

    test('hitungSaldo mengembalikan hasil pengurangan pemasukan dan pengeluaran', () {
      final list = [
        Transaksi(id: '1', keterangan: 'In', nominal: 200, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now()),
        Transaksi(id: '2', keterangan: 'Out', nominal: 50, jenis: JenisTransaksi.pengeluaran, tanggal: DateTime.now()),
      ];
      expect(calculator.hitungSaldo(list), 150.0);
    });

    test('isNominalValid menolak nilai negatif', () {
      expect(calculator.isNominalValid(-50.0), isFalse);
    });

    test('isNominalValid menolak nilai nol', () {
      expect(calculator.isNominalValid(0.0), isFalse);
    });

    test('isPengeluaranValid mengembalikan false jika pengeluaran > saldo', () {
      final list = [
        Transaksi(id: '1', keterangan: 'In', nominal: 100, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now()),
      ];
      expect(calculator.isPengeluaranValid(list, 150.0), isFalse);
    });

    test('isPengeluaranValid mengembalikan true jika pengeluaran tepat sama dengan saldo', () {
      final list = [
        Transaksi(id: '1', keterangan: 'In', nominal: 100, jenis: JenisTransaksi.pemasukan, tanggal: DateTime.now()),
      ];
      expect(calculator.isPengeluaranValid(list, 100.0), isTrue);
    });
  });
}
