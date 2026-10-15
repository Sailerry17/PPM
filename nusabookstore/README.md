# NusaBookstore

Aplikasi katalog buku dan keranjang belanja sederhana menggunakan Flutter dan Provider (`ChangeNotifier`).

## Fitur
- Katalog berisi enam buku dan tombol Tambah ke Keranjang.
- Badge jumlah item pada ikon keranjang diperbarui otomatis.
- Mengubah jumlah buku dengan tombol `+` dan `-`.
- Total item dan total pembayaran otomatis dihitung dalam format Rupiah.
- Checkout menampilkan SnackBar dan mengosongkan keranjang.
- Light Mode dan Dark Mode berlaku di seluruh aplikasi.

## Teknologi
- Flutter
- Dart
- Provider

## Struktur folder
```text
lib/
├── models/
│   └── book.dart
├── providers/
│   ├── cart_provider.dart
│   └── theme_provider.dart
├── screens/
│   ├── catalog_screen.dart
│   └── cart_screen.dart
└── main.dart
```

## Cara menjalankan
```bash
flutter pub get
flutter run
```

## Screenshot aplikasi
Ambil screenshot dari emulator/HP setelah aplikasi dijalankan, lalu simpan di folder `screenshots/` dengan nama berikut. Gambar akan tampil di README setelah file ditambahkan.

### Halaman katalog dan badge keranjang
![Katalog dan badge](screenshots/katalog-badge.png)

### Halaman keranjang dan total pembayaran
![Keranjang dan total](screenshots/keranjang-total.png)

### Light Mode
![Light Mode](screenshots/light-mode.png)

### Dark Mode
![Dark Mode](screenshots/dark-mode.png)

### SnackBar setelah checkout
![Checkout berhasil](screenshots/checkout-snackbar.png)
