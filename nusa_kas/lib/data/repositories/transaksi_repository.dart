import '../../domain/models/transaksi.dart';

class TransaksiRepository {
  final List<Transaksi> _data = [];

  List<Transaksi> getAll() => _data;

  void add(Transaksi transaksi) {
    _data.add(transaksi);
  }

  void delete(String id) {
    _data.removeWhere((t) => t.id == id);
  }
}
