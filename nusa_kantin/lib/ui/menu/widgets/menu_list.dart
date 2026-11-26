import 'package:flutter/material.dart';

import '../../../domain/models/menu_item.dart';
import 'kategori_icon.dart';

/// Daftar menu untuk layar compact (HP). Header (chip kategori) menjadi item
/// pertama agar ikut ter-scroll dan tidak memakan tinggi layar landscape.
class MenuList extends StatelessWidget {
  const MenuList({
    super.key,
    required this.items,
    required this.header,
    required this.onTap,
    required this.onTambah,
  });

  final List<MenuItem> items;
  final Widget header;
  final ValueChanged<MenuItem> onTap;
  final ValueChanged<MenuItem> onTambah;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) return header;
        final item = items[index - 1];
        return _MenuTile(
          item: item,
          onTap: () => onTap(item),
          onTambah: () => onTambah(item),
        );
      },
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.item,
    required this.onTap,
    required this.onTambah,
  });

  final MenuItem item;
  final VoidCallback onTap;
  final VoidCallback onTambah;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.onPrimaryContainer,
                child: Icon(iconForKategori(item.kategori)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nama,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.deskripsi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formatRupiah(item.harga),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Tambah ke pesanan',
                onPressed: onTambah,
                icon: const Icon(Icons.add_shopping_cart),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
