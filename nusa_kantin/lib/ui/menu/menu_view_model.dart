import 'package:flutter/foundation.dart';

import '../../data/repositories/menu_repository.dart';
import '../../domain/models/menu_item.dart';

/// State menu + pesanan. Dipakai bersama oleh MenuScreen dan PesananScreen.
class MenuViewModel extends ChangeNotifier {
  MenuViewModel({required MenuRepository repository})
      : _menu = repository.getMenu(),
        kategoriList = [semua, ...repository.getKategori()];

  static const String semua = 'Semua';

  final List<MenuItem> _menu;
  final List<String> kategoriList;
  final Map<String, int> _jumlah = {};

  String _kategori = semua;
  MenuItem? _terpilih;

  String get kategoriAktif => _kategori;
  MenuItem? get terpilih => _terpilih;

  List<MenuItem> get menuTampil => _kategori == semua
      ? _menu
      : _menu.where((m) => m.kategori == _kategori).toList();

  int jumlahDi(String id) => _jumlah[id] ?? 0;

  List<({MenuItem item, int jumlah})> get pesanan => [
        for (final m in _menu)
          if (jumlahDi(m.id) > 0) (item: m, jumlah: jumlahDi(m.id)),
      ];

  int get totalItem => _jumlah.values.fold(0, (a, b) => a + b);

  int get totalHarga =>
      pesanan.fold(0, (sum, p) => sum + p.item.harga * p.jumlah);

  void pilihKategori(String kategori) {
    _kategori = kategori;
    if (_terpilih != null && !menuTampil.contains(_terpilih)) {
      _terpilih = null;
    }
    notifyListeners();
  }

  void pilihMenu(MenuItem item) {
    _terpilih = item;
    notifyListeners();
  }

  void tambah(MenuItem item) {
    _jumlah[item.id] = jumlahDi(item.id) + 1;
    notifyListeners();
  }

  void kurang(MenuItem item) {
    final sekarang = jumlahDi(item.id);
    if (sekarang <= 1) {
      _jumlah.remove(item.id);
    } else {
      _jumlah[item.id] = sekarang - 1;
    }
    notifyListeners();
  }

  void kosongkan() {
    _jumlah.clear();
    notifyListeners();
  }
}
