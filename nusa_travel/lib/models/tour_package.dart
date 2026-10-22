class TourPackage {
  final int id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;

  const TourPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  /// Contoh: 2500000 -> "Rp 2.500.000"
  String get formattedPrice => formatRupiah(price);

  static const List<TourPackage> dummyData = [
    TourPackage(
      id: 1,
      title: 'Pesona Bali 3 Hari 2 Malam',
      description:
          'Nikmati keindahan Pulau Dewata: Pantai Kuta, Tanah Lot, Ubud, '
          'dan Pura Uluwatu. Sudah termasuk hotel, transportasi, dan pemandu wisata.',
      price: 2500000,
      imageUrl:
          'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800',
    ),
    TourPackage(
      id: 2,
      title: 'Labuan Bajo & Pulau Komodo',
      description:
          'Berlayar menjelajahi Pulau Padar, Pink Beach, dan bertemu langsung '
          'dengan komodo. Termasuk kapal phinisi dan snorkeling.',
      price: 4200000,
      imageUrl:
          'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?w=800',
    ),
    TourPackage(
      id: 3,
      title: 'Raja Ampat Diving Trip',
      description:
          'Surga bawah laut dunia dengan terumbu karang menakjubkan. '
          'Paket 4 hari 3 malam termasuk homestay dan peralatan selam.',
      price: 7800000,
      imageUrl:
          'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf?w=800',
    ),
    TourPackage(
      id: 4,
      title: 'Bromo Sunrise & Malang',
      description:
          'Saksikan matahari terbit di Penanjakan, jelajahi lautan pasir Bromo, '
          'dan kunjungi wisata Kota Batu. Termasuk jeep dan penginapan.',
      price: 1750000,
      imageUrl:
          'https://images.unsplash.com/photo-1588668214407-6ea9a6d8c272?w=800',
    ),
    TourPackage(
      id: 5,
      title: 'Yogyakarta Heritage Tour',
      description:
          'Candi Borobudur, Prambanan, Keraton, dan Malioboro. '
          'Paket budaya 2 hari 1 malam dengan pemandu lokal.',
      price: 1250000,
      imageUrl:
          'https://images.unsplash.com/photo-1584810359583-96fc3448beaa?w=800',
    ),
  ];
}

String formatRupiah(int value) {
  final s = value.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp $buf';
}
