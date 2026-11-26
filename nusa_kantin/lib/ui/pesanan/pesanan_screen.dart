import 'package:flutter/material.dart';

import '../../domain/models/menu_item.dart';
import '../core/window_size.dart';
import '../menu/menu_view_model.dart';
import '../menu/widgets/kategori_icon.dart';

typedef _BarisPesanan = ({MenuItem item, int jumlah});

class PesananScreen extends StatelessWidget {
  const PesananScreen({super.key, required this.viewModel});

  final MenuViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final size = MediaQuery.sizeOf(context);
        // Landscape atau layar lebar: daftar di kiri, ringkasan di kanan.
        final sampingan = !WindowSize.of(context).isCompact ||
            MediaQuery.orientationOf(context) == Orientation.landscape;
        final baris = viewModel.pesanan;

        Widget body;
        if (baris.isEmpty) {
          body = const _PesananKosong();
        } else {
          final daftar = _DaftarPesanan(baris: baris, viewModel: viewModel);
          final ringkasan = _Ringkasan(viewModel: viewModel);

          body = sampingan
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: daftar),
                    const VerticalDivider(width: 1),
                    SizedBox(
                      width: (size.width * 0.35).clamp(280.0, 360.0).toDouble(),
                      child: SingleChildScrollView(child: ringkasan),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: daftar),
                    Material(
                      elevation: 4,
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: size.height * 0.45),
                        child: SingleChildScrollView(child: ringkasan),
                      ),
                    ),
                  ],
                );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Pesanan Saya')),
          body: SafeArea(top: false, child: body),
        );
      },
    );
  }
}

class _DaftarPesanan extends StatelessWidget {
  const _DaftarPesanan({required this.baris, required this.viewModel});

  final List<_BarisPesanan> baris;
  final MenuViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: baris.length,
      itemBuilder: (context, index) {
        final b = baris[index];
        return _KartuPesanan(
          item: b.item,
          jumlah: b.jumlah,
          onTambah: () => viewModel.tambah(b.item),
          onKurang: () => viewModel.kurang(b.item),
        );
      },
    );
  }
}

class _KartuPesanan extends StatelessWidget {
  const _KartuPesanan({
    required this.item,
    required this.jumlah,
    required this.onTambah,
    required this.onKurang,
  });

  final MenuItem item;
  final int jumlah;
  final VoidCallback onTambah;
  final VoidCallback onKurang;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Pada teks besar, kontrol jumlah dipindah ke bawah agar tidak sempit.
    final teksBesar = MediaQuery.textScalerOf(context).scale(1) >= 1.4;

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.nama,
          style: theme.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '${formatRupiah(item.harga)} × $jumlah',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 2),
        Text(
          formatRupiah(item.harga * jumlah),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    final kontrol = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Kurangi',
          onPressed: onKurang,
          icon: const Icon(Icons.remove_circle_outline),
        ),
        Text('$jumlah', style: theme.textTheme.titleMedium),
        IconButton(
          tooltip: 'Tambah',
          onPressed: onTambah,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                  child: Icon(iconForKategori(item.kategori)),
                ),
                const SizedBox(width: 12),
                Expanded(child: info),
                if (!teksBesar) kontrol,
              ],
            ),
            if (teksBesar) Align(alignment: Alignment.centerRight, child: kontrol),
          ],
        ),
      ),
    );
  }
}

class _Ringkasan extends StatelessWidget {
  const _Ringkasan({required this.viewModel});

  final MenuViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Ringkasan', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text('${viewModel.totalItem} item', style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            children: [
              Text('Total', style: theme.textTheme.titleMedium),
              Text(
                formatRupiah(viewModel.totalHarga),
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => _pesan(context),
            icon: const Icon(Icons.check),
            label: const Text('Pesan Sekarang'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: viewModel.kosongkan,
            child: const Text('Kosongkan'),
          ),
        ],
      ),
    );
  }

  void _pesan(BuildContext context) {
    final total = formatRupiah(viewModel.totalHarga);
    viewModel.kosongkan();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Pesanan terkirim. Total $total')));
  }
}

class _PesananKosong extends StatelessWidget {
  const _PesananKosong();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 64, color: theme.colorScheme.outline),
            const SizedBox(height: 12),
            Text('Belum ada pesanan', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Tambahkan menu dari halaman Menu.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
