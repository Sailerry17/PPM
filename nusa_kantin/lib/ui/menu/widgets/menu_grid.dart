import 'package:flutter/material.dart';

import '../../../domain/models/menu_item.dart';
import 'kategori_icon.dart';

/// Grid menu untuk tablet / jendela lebar.
class MenuGrid extends StatelessWidget {
  const MenuGrid({
    super.key,
    required this.items,
    required this.header,
    required this.terpilih,
    required this.onTap,
  });

  final List<MenuItem> items;
  final Widget header;
  final MenuItem? terpilih;
  final ValueChanged<MenuItem> onTap;

  @override
  Widget build(BuildContext context) {
    // Tinggi kartu mengikuti skala teks supaya tidak overflow di 200%.
    final skala =
        MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 3.0).toDouble();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: header),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 80 + 95 * skala,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = items[index];
                return _MenuCard(
                  item: item,
                  selected: item == terpilih,
                  onTap: () => onTap(item),
                );
              },
              childCount: items.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final MenuItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      color: selected ? scheme.primaryContainer : null,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: scheme.secondaryContainer,
                foregroundColor: scheme.onSecondaryContainer,
                child: Icon(iconForKategori(item.kategori), size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                item.nama,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(item.kategori, style: theme.textTheme.bodySmall),
              const Spacer(),
              Text(
                formatRupiah(item.harga),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
