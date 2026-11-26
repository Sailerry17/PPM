import '../../domain/models/menu_item.dart';

/// Sumber data menu kantin (data statis untuk keperluan latihan).
class MenuRepository {
  const MenuRepository();

  List<MenuItem> getMenu() => List.unmodifiable(_data);

  List<String> getKategori() => _data.map((m) => m.kategori).toSet().toList();
}

const _data = <MenuItem>[
  MenuItem(
    id: 'm01',
    nama: 'Nasi Goreng Spesial',
    kategori: 'Makanan',
    harga: 18000,
    deskripsi:
        'Nasi goreng bumbu rempah dengan telur mata sapi, ayam suwir, acar, dan kerupuk.',
  ),
  MenuItem(
    id: 'm02',
    nama: 'Ayam Geprek Sambal Bawang',
    kategori: 'Makanan',
    harga: 20000,
    deskripsi:
        'Ayam crispy digeprek dengan sambal bawang pedas, disajikan dengan nasi hangat dan lalapan.',
  ),
  MenuItem(
    id: 'm03',
    nama: 'Mie Ayam Bakso',
    kategori: 'Makanan',
    harga: 15000,
    deskripsi:
        'Mie kenyal dengan topping ayam kecap, dua butir bakso, dan pangsit goreng.',
  ),
  MenuItem(
    id: 'm04',
    nama: 'Soto Ayam Lamongan',
    kategori: 'Makanan',
    harga: 16000,
    deskripsi:
        'Soto kuning bening dengan suwiran ayam, telur rebus, soun, dan koya gurih.',
  ),
  MenuItem(
    id: 'm05',
    nama: 'Gado-Gado',
    kategori: 'Makanan',
    harga: 14000,
    deskripsi:
        'Sayuran rebus, tahu, tempe, dan lontong dengan siraman bumbu kacang.',
  ),
  MenuItem(
    id: 'm06',
    nama: 'Es Teh Manis',
    kategori: 'Minuman',
    harga: 5000,
    deskripsi: 'Teh seduh dingin dengan gula pas, penyegar saat jam kuliah siang.',
  ),
  MenuItem(
    id: 'm07',
    nama: 'Es Jeruk Peras',
    kategori: 'Minuman',
    harga: 7000,
    deskripsi: 'Jeruk peras asli dengan es batu, segar dan kaya vitamin C.',
  ),
  MenuItem(
    id: 'm08',
    nama: 'Kopi Susu Kampus',
    kategori: 'Minuman',
    harga: 12000,
    deskripsi:
        'Espresso, susu segar, dan gula aren. Teman setia begadang mengerjakan tugas.',
  ),
  MenuItem(
    id: 'm09',
    nama: 'Jus Alpukat',
    kategori: 'Minuman',
    harga: 14000,
    deskripsi: 'Alpukat mentega diblender dengan susu cokelat kental manis.',
  ),
  MenuItem(
    id: 'm10',
    nama: 'Pisang Goreng',
    kategori: 'Camilan',
    harga: 8000,
    deskripsi: 'Pisang kepok digoreng dengan balutan tepung renyah, tiga potong.',
  ),
  MenuItem(
    id: 'm11',
    nama: 'Batagor',
    kategori: 'Camilan',
    harga: 10000,
    deskripsi: 'Batagor ikan tenggiri khas Bandung dengan saus kacang dan kecap.',
  ),
  MenuItem(
    id: 'm12',
    nama: 'Risoles Mayo',
    kategori: 'Camilan',
    harga: 6000,
    deskripsi: 'Kulit risoles tipis berisi ayam, sayur, dan mayones.',
  ),
];
