import 'package:flutter/material.dart';

import 'data/repositories/menu_repository.dart';
import 'ui/core/window_size.dart';
import 'ui/menu/menu_screen.dart';
import 'ui/menu/menu_view_model.dart';
import 'ui/pesanan/pesanan_screen.dart';

void main() => runApp(const NusaKantinApp());

class NusaKantinApp extends StatelessWidget {
  const NusaKantinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaKantin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: const HomeShell(),
    );
  }
}

/// Cangkang navigasi: NavigationBar di HP (compact), NavigationRail di
/// tablet / jendela lebar (medium & expanded).
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final MenuViewModel _vm = MenuViewModel(repository: const MenuRepository());
  int _index = 0;

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  void _pilih(int index) => setState(() => _index = index);

  Widget _ikonPesanan(IconData icon) => Badge(
        isLabelVisible: _vm.totalItem > 0,
        label: Text('${_vm.totalItem}'),
        child: Icon(icon),
      );

  @override
  Widget build(BuildContext context) {
    final size = WindowSize.of(context);
    final body = IndexedStack(
      index: _index,
      children: [
        MenuScreen(viewModel: _vm),
        PesananScreen(viewModel: _vm),
      ],
    );

    if (size.isCompact) {
      return Scaffold(
        body: body,
        bottomNavigationBar: ListenableBuilder(
          listenable: _vm,
          builder: (context, _) => NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: _pilih,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.restaurant_menu_outlined),
                selectedIcon: Icon(Icons.restaurant_menu),
                label: 'Menu',
              ),
              NavigationDestination(
                icon: _ikonPesanan(Icons.receipt_long_outlined),
                selectedIcon: _ikonPesanan(Icons.receipt_long),
                label: 'Pesanan',
              ),
            ],
          ),
        ),
      );
    }

    final extended = size == WindowSize.expanded;
    final teksBesar = MediaQuery.textScalerOf(context).scale(1) > 1.5;

    return Scaffold(
      body: SafeArea(
        top: false, // AppBar di tiap halaman menangani sisi atas
        child: Row(
          children: [
            ListenableBuilder(
              listenable: _vm,
              builder: (context, _) => NavigationRail(
                selectedIndex: _index,
                onDestinationSelected: _pilih,
                extended: extended,
                // extended mewajibkan labelType none; label teks besar disembunyikan
                labelType: (extended || teksBesar)
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.all,
                destinations: [
                  const NavigationRailDestination(
                    icon: Icon(Icons.restaurant_menu_outlined),
                    selectedIcon: Icon(Icons.restaurant_menu),
                    label: Text('Menu'),
                  ),
                  NavigationRailDestination(
                    icon: _ikonPesanan(Icons.receipt_long_outlined),
                    selectedIcon: _ikonPesanan(Icons.receipt_long),
                    label: const Text('Pesanan'),
                  ),
                ],
              ),
            ),
            const VerticalDivider(width: 1, thickness: 1),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
