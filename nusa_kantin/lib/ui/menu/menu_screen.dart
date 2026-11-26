import 'package:flutter/material.dart';

import '../../domain/models/menu_item.dart';
import '../core/window_size.dart';
import 'menu_view_model.dart';
import 'widgets/menu_detail.dart';
import 'widgets/menu_grid.dart';
import 'widgets/menu_list.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required this.viewModel});

  final MenuViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final size = WindowSize.of(context);
        final header = _KategoriChips(viewModel: viewModel);

        return Scaffold(
          appBar: AppBar(title: const Text('Menu Kantin')),
          body: SafeArea(
            top: false, // sisi atas sudah ditangani AppBar
            child: size.isCompact
                ? MenuList(
                    items: viewModel.menuTampil,
                    header: header,
                    onTap: (item) => _bukaDetailSheet(context, item),
                    onTambah: (item) => _tambah(context, item),
                  )
                : _TabletBody(viewModel: viewModel, header: header),
          ),
        );
      },
    );
  }

  void _tambah(BuildContext context, MenuItem item) {
    viewModel.tambah(item);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${item.nama} ditambahkan'),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  /// Di HP, detail menu tampil sebagai bottom sheet.
  void _bukaDetailSheet(BuildContext context, MenuItem item) {
    viewModel.pilihMenu(item);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) => SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.8,
            ),
            child: MenuDetail(
              item: item,
              jumlah: viewModel.jumlahDi(item.id),
              onTambah: () => viewModel.tambah(item),
              onKurang: () => viewModel.kurang(item),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tablet: grid di kiri, panel detail di kanan. Lebar panel detail dihitung
/// dari ruang yang tersedia (LayoutBuilder).
class _TabletBody extends StatelessWidget {
  const _TabletBody({required this.viewModel, required this.header});

  final MenuViewModel viewModel;
  final Widget header;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final lebarDetail =
            (constraints.maxWidth * 0.38).clamp(280.0, 400.0).toDouble();
        final terpilih = viewModel.terpilih;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MenuGrid(
                items: viewModel.menuTampil,
                header: header,
                terpilih: terpilih,
                onTap: viewModel.pilihMenu,
              ),
            ),
            const VerticalDivider(width: 1),
            SizedBox(
              width: lebarDetail,
              child: MenuDetail(
                item: terpilih,
                jumlah: terpilih == null ? 0 : viewModel.jumlahDi(terpilih.id),
                onTambah: () {
                  if (terpilih != null) viewModel.tambah(terpilih);
                },
                onKurang: () {
                  if (terpilih != null) viewModel.kurang(terpilih);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _KategoriChips extends StatelessWidget {
  const _KategoriChips({required this.viewModel});

  final MenuViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final kategori in viewModel.kategoriList)
            ChoiceChip(
              label: Text(kategori),
              selected: kategori == viewModel.kategoriAktif,
              onSelected: (_) => viewModel.pilihKategori(kategori),
            ),
        ],
      ),
    );
  }
}
