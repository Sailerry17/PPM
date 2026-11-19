enum JenisTransaksi { pemasukan, pengeluaran }

class Transaksi {
  final String id;
  final String keterangan;
  final double nominal;
  final JenisTransaksi jenis;
  final DateTime tanggal;

  Transaksi({
    required this.id,
    required this.keterangan,
    required this.nominal,
    required this.jenis,
    required this.tanggal,
  });
}
