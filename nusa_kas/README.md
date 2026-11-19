# NusaKas

Aplikasi pencatatan arus kas himpunan berbasis Flutter dengan Unit Test, Widget Test, dan Integration Test.

## Struktur Folder
- `lib/domain/` - Model (`Transaksi`) dan logika perhitungan (`KasCalculator`)
- `lib/data/` - Repository penyimpanan data (`TransaksiRepository`)
- `lib/ui/kas/` - State management (`KasViewModel`) dan halaman UI (`HomeScreen`, `TambahTransaksiScreen`)
- `test/unit/` - Unit test untuk `KasCalculator`
- `test/widget/` - Widget test untuk `TambahTransaksiScreen`
- `integration_test/` - Integration test end-to-end

## Menjalankan Aplikasi & Pengujian
```bash
flutter pub get
flutter test
flutter test integration_test/app_test.dart
```

## Screenshots
- **Home Screen**
  *(Tambahkan screenshot Home Screen di sini)*
- **Tambah Transaksi Screen**
  *(Tambahkan screenshot Tambah Transaksi Screen di sini)*

## Test Results
- **Unit & Widget Test (`flutter test`)**
  *(Tambahkan screenshot hasil `flutter test` di sini)*
- **Integration Test (`flutter test integration_test`)**
  *(Tambahkan screenshot hasil integration test di sini)*
