# NusaTravel

Aplikasi Flutter sederhana untuk latihan **Navigation & Routing**.

## Fitur
- `MaterialApp` dengan `initialRoute`, `routes`, `onGenerateRoute`, `onUnknownRoute`
- Splash -> Home memakai `pushReplacementNamed()`
- Home -> Detail memakai `pushNamed()` + `arguments` (objek `TourPackage`)
- Detail -> Booking memakai `await Navigator.push()`, hasil dikembalikan lewat `Navigator.pop(context, result)`
- `SnackBar` di Detail setelah pemesanan berhasil
- `PopScope` di Booking: dialog konfirmasi saat tombol Back ditekan
- Logout memakai `pushNamedAndRemoveUntil()` (riwayat halaman dihapus)
- Halaman 404 lewat `onUnknownRoute` (tombol ikon bug di AppBar Home untuk mengetes)

## Struktur
```
lib/
├── models/tour_package.dart
├── routes/app_routes.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── detail_screen.dart
│   ├── booking_screen.dart
│   └── not_found_screen.dart
└── main.dart
```

## Cara Menjalankan
```bash
flutter pub get
flutter run
```

## Screenshot

| Splash | Home |
|---|---|
| ![Splash](screenshots/01_splash.png) | ![Home](screenshots/02_home.png) |

| Detail | Booking |
|---|---|
| ![Detail](screenshots/03_detail.png) | ![Booking](screenshots/04_booking.png) |

| Dialog PopScope | SnackBar setelah pemesanan |
|---|---|
| ![PopScope](screenshots/05_popscope_dialog.png) | ![SnackBar](screenshots/06_snackbar.png) |

| 404 Not Found |
|---|
| ![404](screenshots/07_not_found.png) |
