import 'models/transaksi.dart';

class KasCalculator {
  double totalPemasukan(List<Transaksi> transaksiList) {
    return transaksiList
        .where((t) => t.jenis == JenisTransaksi.pemasukan)
        .fold(0.0, (sum, t) => sum + t.nominal);
  }

  double totalPengeluaran(List<Transaksi> transaksiList) {
    return transaksiList
        .where((t) => t.jenis == JenisTransaksi.pengeluaran)
        .fold(0.0, (sum, t) => sum + t.nominal);
  }

  double hitungSaldo(List<Transaksi> transaksiList) {
    return totalPemasukan(transaksiList) - totalPengeluaran(transaksiList);
  }

  bool isNominalValid(double nominal) {
    return nominal > 0;
  }

  bool isPengeluaranValid(List<Transaksi> transaksiList, double pengeluaranBaru) {
    return hitungSaldo(transaksiList) >= pengeluaranBaru;
  }
}
