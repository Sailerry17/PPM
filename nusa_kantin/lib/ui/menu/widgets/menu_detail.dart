import 'package:flutter/material.dart';

import '../../../domain/models/menu_item.dart';
import 'kategori_icon.dart';

/// Panel detail menu. Tata letaknya bergantung pada lebar yang diberikan
/// induknya (side panel tablet atau bottom sheet HP), sehingga memakai
/// [LayoutBuilder] bukan MediaQuery.
class MenuDetail extends StatelessWidget {
  const MenuDetail({
    super.key,
    required this.item,
    required this.jumlah,
    required this.onTambah,
    required this.onKurang,
  });

  final MenuItem? item;
  final int jumlah;
  final VoidCallback onTambah;
  final VoidCallback onKurang;

  @override
  Widget build(BuildContext context) {
    final item = this.item;
    if (item == null) return const _DetailKosong();

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final lebar = constraints.maxWidth >= 480;
        final ukuranIkon =
            (constraints.maxWidth * 0.4).clamp(72.0, 140.0).toDouble();

        final gambar = Container(
          width: ukuranIkon,
          height: ukuranIkon,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            iconForKategori(item.kategori),
            size: ukuranIkon * 0.5,
            color: scheme.onPrimaryContainer,
          ),
        );

        final teks = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.nama,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  avatar: Icon(iconForKategori(item.kategori), size: 18),
                  label: Text(item.kategori),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              formatRupiah(item.harga),
              style: theme.textTheme.titleLarge?.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(item.deskripsi, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (jumlah > 0)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.outlined(
                        tooltip: 'Kurangi',
                        onPressed: onKurang,
                        icon: const Icon(Icons.remove),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '$jumlah',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                FilledButton.icon(
                  onPressed: onTambah,
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Tambah'),
                ),
              ],
            ),
          ],
        );

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: lebar
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gambar,
                    const SizedBox(width: 16),
                    Expanded(child: teks),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gambar,
                    const SizedBox(height: 16),
                    teks,
                  ],
                ),
        );
      },
    );
  }
}

class _DetailKosong extends StatelessWidget {
  const _DetailKosong();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.touch_app_outlined,
                size: 48, color: theme.colorScheme.outline),
            const SizedBox(height: 12),
            Text(
              'Pilih menu untuk melihat detail',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
