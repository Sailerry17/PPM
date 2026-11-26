/// Satu item menu di kantin kampus.
class MenuItem {
  const MenuItem({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
  });

  final String id;
  final String nama;
  final String kategori;

  /// Harga dalam rupiah.
  final int harga;
  final String deskripsi;

  @override
  bool operator ==(Object other) => other is MenuItem && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Format angka menjadi "Rp 18.000".
String formatRupiah(int nilai) {
  final s = nilai.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp $buf';
}
