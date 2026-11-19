import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/transaksi.dart';
import 'kas_view_model.dart';
import 'tambah_transaksi_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<KasViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('NusaKas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Saldo: Rp ${viewModel.saldo}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pemasukan: Rp ${viewModel.totalPemasukan}',
                          style: const TextStyle(color: Colors.green),
                        ),
                        Text(
                          'Pengeluaran: Rp ${viewModel.totalPengeluaran}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.transaksiList.length,
              itemBuilder: (context, index) {
                final t = viewModel.transaksiList[index];
                return Dismissible(
                  key: Key(t.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => viewModel.hapusTransaksi(t.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(t.keterangan),
                    subtitle: Text(t.jenis.name),
                    trailing: Text(
                      'Rp ${t.nominal}',
                      style: TextStyle(
                        color: t.jenis == JenisTransaksi.pemasukan ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('fabTambah'),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TambahTransaksiScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
