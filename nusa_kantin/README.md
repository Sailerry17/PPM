# NusaKantin

Aplikasi Flutter sederhana untuk menampilkan menu kantin kampus dan pesanan,
dengan layout responsif (HP portrait/landscape, tablet, dan jendela lebar).

## Fitur

- **Menu Screen**
  - HP (compact, lebar < 600): daftar menu `ListView.builder`; detail menu tampil
    sebagai bottom sheet.
  - Tablet (medium 600–839 dan expanded ≥ 840): grid menu
    `SliverGridDelegateWithMaxCrossAxisExtent` dengan panel detail di sampingnya.
  - Filter kategori memakai `Wrap` + `ChoiceChip`.
- **Pesanan Screen**: daftar pesanan, ubah jumlah, total harga. Di landscape atau
  layar lebar ringkasan pindah ke samping, di portrait HP ada di bawah.
- **Navigasi**: `NavigationBar` (compact) / `NavigationRail` (medium & expanded;
  `extended` di expanded).
- Tahan teks 200% dan landscape: item scrollable, `Wrap` untuk baris yang bisa
  melebar, tinggi kartu grid mengikuti skala teks, `SafeArea` di semua halaman.

## Arsitektur

```
lib/
├── main.dart                         # app + HomeShell (NavigationBar / NavigationRail)
├── domain/models/menu_item.dart      # model MenuItem + formatRupiah
├── data/repositories/menu_repository.dart
└── ui/
    ├── core/window_size.dart         # compact / medium / expanded via MediaQuery.sizeOf
    ├── menu/
    │   ├── menu_view_model.dart      # ChangeNotifier: kategori, pilihan, keranjang
    │   ├── menu_screen.dart
    │   └── widgets/
    │       ├── menu_list.dart        # ListView.builder (HP)
    │       ├── menu_grid.dart        # SliverGridDelegateWithMaxCrossAxisExtent (tablet)
    │       ├── menu_detail.dart      # panel detail, memakai LayoutBuilder
    │       └── kategori_icon.dart    # helper ikon kategori
    └── pesanan/pesanan_screen.dart
test/widget/responsive_layout_test.dart
```

`LayoutBuilder` dipakai di `MenuDetail` (tata letak mengikuti lebar induknya) dan
di `_TabletBody` (lebar panel detail dihitung dari ruang yang tersedia).

## Menjalankan

```bash
flutter pub get
flutter run            # pilih emulator HP / tablet / Chrome (jendela lebar)
flutter test           # menjalankan widget test
```

Jika folder platform (`android/`, `ios/`, dst.) belum ada, jalankan
`flutter create . --project-name nusa_kantin` di folder project.

## Widget test

`test/widget/responsive_layout_test.dart` mengatur ukuran layar lewat
`tester.view.physicalSize` dan memeriksa:

- HP 400×800 → `NavigationBar` + `ListView`
- Tablet 700×900 → `NavigationRail` + grid + panel detail
- Tablet 1200×800 → rail `extended`
- Alur tambah menu → total muncul di Pesanan
- HP landscape 800×360 dan HP kecil 320×568 tanpa overflow
- Teks 200% di HP dan tablet tanpa overflow

## Screenshot

Taruh hasil tangkapan layar di `docs/screenshots/` lalu pastikan nama filenya sama.

| Halaman | HP (portrait) | Tablet |
|---|---|---|
| Menu | ![Menu HP](docs/screenshots/menu_hp.png) | ![Menu tablet](docs/screenshots/menu_tablet.png) |
| Pesanan | ![Pesanan HP](docs/screenshots/pesanan_hp.png) | ![Pesanan tablet](docs/screenshots/pesanan_tablet.png) |

Tambahan: landscape HP

| Menu | Pesanan |
|---|---|
| ![Menu landscape](docs/screenshots/menu_hp_landscape.png) | ![Pesanan landscape](docs/screenshots/pesanan_hp_landscape.png) |
