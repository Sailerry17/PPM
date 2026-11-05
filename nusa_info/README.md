# NusaInfo

Aplikasi Flutter sederhana untuk menampilkan, melihat detail, dan membuat pengumuman
menggunakan API [JSONPlaceholder](https://jsonplaceholder.typicode.com) dan package `http`.

## Fitur
- Daftar pengumuman (`GET /posts`) dengan `FutureBuilder` + `ListView.builder`, loading, error, tombol **Coba Lagi**, dan `RefreshIndicator`
- Detail pengumuman beserta komentar (`GET /posts/{id}/comments`)
- Tambah pengumuman (`POST /posts`) dengan validasi `GlobalKey<FormState>` dan `jsonEncode()`
- `SnackBar` di Home Screen setelah pengumuman berhasil dibuat

## Struktur Folder
```
lib/
├── models/post.dart
├── services/post_service.dart
├── screens/
│   ├── home_screen.dart
│   ├── detail_screen.dart
│   └── add_post_screen.dart
└── main.dart
```

## Cara Menjalankan
```bash
flutter pub get
flutter run
```

## Screenshot
| Home Screen | Detail Screen | Add Post Screen |
|---|---|---|
| ![Home](screenshots/home.png) | ![Detail](screenshots/detail.png) | ![Add](screenshots/add_post.png) |

| Error saat internet mati | SnackBar setelah berhasil |
|---|---|
| ![Error](screenshots/error.png) | ![SnackBar](screenshots/snackbar.png) |
