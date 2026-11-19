import 'package:flutter/material.dart';
import '../../domain/kas_calculator.dart';
import '../../domain/models/transaksi.dart';
import '../../data/repositories/transaksi_repository.dart';

class KasViewModel extends ChangeNotifier {
  final TransaksiRepository _repository;
  final KasCalculator _calculator;

  KasViewModel(this._repository, this._calculator);

  List<Transaksi> get transaksiList => _repository.getAll();
  double get saldo => _calculator.hitungSaldo(transaksiList);
  double get totalPemasukan => _calculator.totalPemasukan(transaksiList);
  double get totalPengeluaran => _calculator.totalPengeluaran(transaksiList);

  String? tambahTransaksi(String keterangan, double nominal, JenisTransaksi jenis) {
    if (!_calculator.isNominalValid(nominal)) {
      return 'Nominal harus lebih dari 0';
    }

    if (jenis == JenisTransaksi.pengeluaran && !_calculator.isPengeluaranValid(transaksiList, nominal)) {
      return 'Pengeluaran melebihi saldo';
    }

    final transaksi = Transaksi(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      keterangan: keterangan,
      nominal: nominal,
      jenis: jenis,
      tanggal: DateTime.now(),
    );

    _repository.add(transaksi);
    notifyListeners();
    return null;
  }

  void hapusTransaksi(String id) {
    _repository.delete(id);
    notifyListeners();
  }
}
