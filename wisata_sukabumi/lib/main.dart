import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Wisata Sukabumi - panduan destinasi, favorit, dan rencana kunjungan.
// Tanpa package tambahan. Harga bersifat perkiraan dan bisa berubah.
// ---------------------------------------------------------------------------

void main() => runApp(const WisataApp());

const hijau = Color(0xFF1F5F4A);
const laut = Color(0xFF0B4F6C);
const pasir = Color(0xFFF3F7F6);
const tinta = Color(0xFF14232B);
const matahari = Color(0xFFF2A33A);

const kategori = ['Semua', 'Pantai', 'Alam', 'Gunung', 'Budaya'];

// ----------------------------- Model & data --------------------------------

class Destination {
  const Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    required this.rating,
    required this.price,
    required this.description,
    required this.highlights,
    required this.facilities,
    required this.bestTime,
    required this.tips,
    required this.colors,
    required this.icon,
  });

  final int id;
  final String name;
  final String location;
  final String category;
  final double rating;
  final int price; // perkiraan biaya per orang (rupiah)
  final String description;
  final List<String> highlights;
  final List<String> facilities;
  final String bestTime;
  final List<String> tips;
  final List<Color> colors;
  final IconData icon;
}

const destinations = <Destination>[
  Destination(
    id: 1,
    name: 'Ciletuh Geopark',
    location: 'Ciemas, Sukabumi',
    category: 'Alam',
    rating: 4.8,
    price: 50000,
    description:
        'Kawasan geopark berstatus UNESCO dengan tebing, teluk berbentuk '
        'tapal kuda, air terjun, dan pantai dalam satu rute perjalanan.',
    highlights: [
      'Pemandangan Teluk Ciletuh dari Puncak Panenjoan',
      'Curug Awang dan Curug Cimarinjung',
      'Bersantai di Pantai Palangpang',
    ],
    facilities: ['Homestay', 'Pemandu lokal', 'Warung makan'],
    bestTime: 'Musim kemarau (Mei-Oktober), berangkat pagi hari.',
    tips: [
      'Jalan menuju lokasi berkelok, pastikan kendaraan dalam kondisi prima.',
      'Sinyal bisa lemah di beberapa titik, unduh peta offline.',
      'Bawa uang tunai untuk parkir dan warung.',
    ],
    colors: [Color(0xFF1F5F4A), Color(0xFF3F9C78)],
    icon: Icons.landscape,
  ),
  Destination(
    id: 2,
    name: 'Curug Cikaso',
    location: 'Surade, Sukabumi',
    category: 'Alam',
    rating: 4.7,
    price: 40000,
    description:
        'Air terjun bertingkat dengan tiga aliran lebar yang jatuh ke kolam '
        'berwarna hijau kebiruan. Bisa dicapai dengan perahu atau berjalan kaki.',
    highlights: [
      'Naik perahu menyusuri sungai menuju curug',
      'Berfoto di depan tiga aliran air terjun',
      'Bermain air di sekitar kolam',
    ],
    facilities: ['Perahu', 'Pelampung', 'Warung', 'Toilet'],
    bestTime: 'Pagi hari agar tidak terlalu ramai dan cahaya lebih bagus.',
    tips: [
      'Batu di sekitar curug licin, pakai alas kaki anti selip.',
      'Gunakan pelampung saat naik perahu.',
      'Saat hujan deras, debit air naik, tunda kunjungan.',
    ],
    colors: [Color(0xFF0E6B5C), Color(0xFF38B6A0)],
    icon: Icons.water_drop,
  ),
  Destination(
    id: 3,
    name: 'Ujung Genteng',
    location: 'Ciracap, Sukabumi',
    category: 'Pantai',
    rating: 4.7,
    price: 150000,
    description:
        'Ujung selatan Sukabumi dengan pantai berpasir putih, ombak untuk '
        'berselancar, dan kawasan penangkaran penyu.',
    highlights: [
      'Melihat penyu bertelur dan pelepasan tukik di Pangumbahan',
      'Berselancar di Pantai Ombak Tujuh',
      'Menikmati ikan bakar di tepi pantai',
    ],
    facilities: ['Penginapan', 'Warung seafood', 'Sewa papan selancar'],
    bestTime: 'Akhir pekan panjang di musim kemarau; jadwal tukik tidak tentu.',
    tips: [
      'Perjalanan cukup jauh, berangkat pagi dan rencanakan menginap.',
      'Jaga jarak dan jangan memakai lampu kilat di dekat penyu.',
      'Pesan penginapan lebih awal saat libur panjang.',
    ],
    colors: [Color(0xFF0B4F6C), Color(0xFF1A8FA3)],
    icon: Icons.beach_access,
  ),
  Destination(
    id: 4,
    name: 'Pantai Karang Hawu',
    location: 'Cisolok, Sukabumi',
    category: 'Pantai',
    rating: 4.4,
    price: 25000,
    description:
        'Pantai dengan tebing karang besar yang dihantam ombak Samudra '
        'Hindia. Terkenal dengan cerita rakyat dan pemandangan matahari terbenam.',
    highlights: [
      'Sunset di atas karang',
      'Menyusuri tebing dan gua karang',
      'Makan seafood di warung sekitar',
    ],
    facilities: ['Parkir', 'Warung', 'Penginapan terdekat'],
    bestTime: 'Sore hari menjelang matahari terbenam.',
    tips: [
      'Ombak selatan kuat, jangan berenang terlalu ke tengah.',
      'Perhatikan papan peringatan dan arahan petugas pantai.',
      'Hati-hati saat berjalan di karang yang basah.',
    ],
    colors: [Color(0xFF2B3A55), Color(0xFF4F6D9A)],
    icon: Icons.waves,
  ),
  Destination(
    id: 5,
    name: 'Situ Gunung',
    location: 'Kadudampit, Sukabumi',
    category: 'Gunung',
    rating: 4.6,
    price: 50000,
    description:
        'Danau di kawasan Taman Nasional Gunung Gede Pangrango dengan hutan '
        'pinus, jalur jalan kaki, dan jembatan gantung yang panjang.',
    highlights: [
      'Menyeberangi jembatan gantung di atas lembah',
      'Berjalan ke Curug Sawer',
      'Berkemah di area camping ground',
    ],
    facilities: ['Camping ground', 'Warung', 'Musala', 'Toilet'],
    bestTime: 'Pagi hari di hari kerja agar suasana tenang.',
    tips: [
      'Udara dingin, bawa jaket tipis.',
      'Pakai sepatu yang nyaman untuk jalur menanjak.',
      'Ikuti aturan taman nasional dan bawa pulang sampahmu.',
    ],
    colors: [Color(0xFF1B4332), Color(0xFF52B788)],
    icon: Icons.forest,
  ),
  Destination(
    id: 6,
    name: 'Pantai Cimaja',
    location: 'Cikakak, Sukabumi',
    category: 'Pantai',
    rating: 4.5,
    price: 60000,
    description:
        'Salah satu titik selancar populer di Sukabumi. Cocok untuk belajar '
        'berselancar atau sekadar menonton para peselancar dari pantai.',
    highlights: [
      'Kelas selancar untuk pemula',
      'Menonton peselancar di sore hari',
      'Berjalan santai di sepanjang pantai',
    ],
    facilities: ['Sewa papan', 'Instruktur', 'Homestay', 'Kafe'],
    bestTime: 'Pagi atau sore hari; ombak lebih besar di musim tertentu.',
    tips: [
      'Pemula sebaiknya ditemani instruktur.',
      'Pakai tabir surya, matahari pantai selatan terik.',
      'Tanyakan kondisi ombak sebelum turun ke air.',
    ],
    colors: [Color(0xFF0A4D68), Color(0xFF088395)],
    icon: Icons.surfing,
  ),
  Destination(
    id: 7,
    name: 'Puncak Darma',
    location: 'Cisolok, Sukabumi',
    category: 'Gunung',
    rating: 4.5,
    price: 30000,
    description:
        'Bukit dengan pemandangan Teluk Pelabuhanratu dari ketinggian. '
        'Dikenal sebagai lokasi paralayang dan tempat menikmati matahari terbit.',
    highlights: [
      'Pemandangan teluk dari atas bukit',
      'Menonton atau mencoba paralayang tandem (biaya terpisah)',
      'Matahari terbit dan lautan awan di pagi hari',
    ],
    facilities: ['Parkir', 'Warung', 'Spot foto'],
    bestTime: 'Subuh untuk matahari terbit, cuaca cerah tanpa hujan.',
    tips: [
      'Jalan menanjak, pastikan rem kendaraan baik.',
      'Paralayang tergantung cuaca dan angin.',
      'Bawa jaket karena angin di puncak kencang.',
    ],
    colors: [Color(0xFF3D348B), Color(0xFF7678ED)],
    icon: Icons.flight,
  ),
  Destination(
    id: 8,
    name: 'Geyser Cisolok',
    location: 'Cisolok, Sukabumi',
    category: 'Alam',
    rating: 4.3,
    price: 20000,
    description:
        'Sumber air panas alami yang menyembur dan mengalir ke sungai. '
        'Cocok untuk berendam kaki setelah perjalanan panjang.',
    highlights: [
      'Berendam kaki di aliran air hangat',
      'Melihat semburan air panas dari kejauhan',
      'Menikmati suasana sungai berbatu',
    ],
    facilities: ['Area berendam', 'Warung', 'Toilet'],
    bestTime: 'Pagi atau sore hari saat udara lebih sejuk.',
    tips: [
      'Jangan mendekati titik semburan, airnya sangat panas.',
      'Ikuti arahan petugas tentang area aman berendam.',
      'Bawa handuk dan pakaian ganti.',
    ],
    colors: [Color(0xFF7F1D1D), Color(0xFFD9534F)],
    icon: Icons.hot_tub,
  ),
  Destination(
    id: 9,
    name: 'Kasepuhan Ciptagelar',
    location: 'Cisolok, Sukabumi',
    category: 'Budaya',
    rating: 4.7,
    price: 100000,
    description:
        'Kampung adat Sunda yang menjaga tradisi bertani padi dan hidup '
        'selaras dengan alam. Lumbung padi (leuit) menjadi ciri khasnya.',
    highlights: [
      'Melihat leuit dan sawah berundak',
      'Mengenal tradisi tani warga adat',
      'Upacara adat Seren Taun (waktunya berbeda tiap tahun)',
    ],
    facilities: ['Homestay warga', 'Pemandu kampung'],
    bestTime: 'Musim panen atau saat upacara adat; konfirmasi jadwal dahulu.',
    tips: [
      'Hormati adat dan tanyakan aturan sebelum memotret.',
      'Akses jalan menanjak, tanyakan kondisi terkini sebelum berangkat.',
      'Datang dengan sikap sopan dan berpakaian rapi.',
    ],
    colors: [Color(0xFF4A3B2A), Color(0xFF8C6D46)],
    icon: Icons.cottage,
  ),
  Destination(
    id: 10,
    name: 'Kebun Teh Goalpara',
    location: 'Sukaraja, Sukabumi',
    category: 'Gunung',
    rating: 4.4,
    price: 25000,
    description:
        'Hamparan kebun teh berudara sejuk di dataran tinggi. Tempat yang '
        'pas untuk berjalan santai, berfoto, dan menikmati kopi di pagi hari.',
    highlights: [
      'Berjalan di antara barisan pohon teh',
      'Berfoto di spot kebun',
      'Sarapan dengan udara pegunungan',
    ],
    facilities: ['Parkir', 'Warung', 'Area camping'],
    bestTime: 'Pagi hari saat kabut tipis masih ada.',
    tips: [
      'Jangan memetik teh tanpa izin pengelola.',
      'Bawa jaket, suhu pagi cukup dingin.',
      'Jaga kebersihan dan jangan menginjak tanaman.',
    ],
    colors: [Color(0xFF2D6A4F), Color(0xFF95D5B2)],
    icon: Icons.grass,
  ),
];

class Booking {
  Booking(this.dest, this.date, this.people);
  final Destination dest;
  final DateTime date;
  final int people;
  int get total => dest.price * people;
}

// ------------------------------- State -------------------------------------

class Store extends ChangeNotifier {
  final Set<int> favorites = {};
  final List<Booking> bookings = [];

  bool isFav(int id) => favorites.contains(id);

  void toggleFav(int id) {
    favorites.contains(id) ? favorites.remove(id) : favorites.add(id);
    notifyListeners();
  }

  void book(Booking b) {
    bookings.add(b);
    notifyListeners();
  }

  void cancel(Booking b) {
    bookings.remove(b);
    notifyListeners();
  }
}

final store = Store();

// ------------------------------ Helper -------------------------------------

String rupiah(int v) {
  final s = v.toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write('.');
    b.write(s[i]);
  }
  return 'Rp$b';
}

String tanggal(DateTime d) {
  const bulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];
  return '${d.day} ${bulan[d.month - 1]} ${d.year}';
}

// -------------------------------- App --------------------------------------

class WisataApp extends StatelessWidget {
  const WisataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Sukabumi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: hijau, primary: hijau),
        scaffoldBackgroundColor: pasir,
      ),
      home: const Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) => Scaffold(
        body: IndexedStack(
          index: index,
          children: const [HomePage(), FavoritesPage(), TripsPage()],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (i) => setState(() => index = i),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Jelajah',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: store.favorites.isNotEmpty,
                label: Text('${store.favorites.length}'),
                child: const Icon(Icons.favorite_border),
              ),
              selectedIcon: const Icon(Icons.favorite),
              label: 'Favorit',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: store.bookings.isNotEmpty,
                label: Text('${store.bookings.length}'),
                child: const Icon(Icons.event_note_outlined),
              ),
              selectedIcon: const Icon(Icons.event_note),
              label: 'Rencana',
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------- Beranda -----------------------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String q = '';
  String cat = 'Semua';

  @override
  Widget build(BuildContext context) {
    final key = q.toLowerCase();
    final list = destinations.where((d) {
      final okCat = cat == 'Semua' || d.category == cat;
      final okQ = d.name.toLowerCase().contains(key) ||
          d.location.toLowerCase().contains(key);
      return okCat && okQ;
    }).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Text(
            'Mau ke mana?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: tinta,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '${destinations.length} destinasi wisata di Sukabumi.',
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (v) => setState(() => q = v),
            decoration: InputDecoration(
              hintText: 'Cari destinasi atau kecamatan',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: kategori.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final k = kategori[i];
                final on = cat == k;
                return ChoiceChip(
                  label: Text(k),
                  selected: on,
                  showCheckmark: false,
                  selectedColor: hijau,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(color: on ? Colors.white : tinta),
                  onSelected: (_) => setState(() => cat = k),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          if (list.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Text('Tidak ada destinasi yang cocok. Coba kata kunci lain.'),
              ),
            ),
          for (final d in list) DestinationCard(d),
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  const DestinationCard(this.d, {super.key});
  final Destination d;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        borderRadius: BorderRadius.circular(22),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailPage(d)),
          ),
          child: Ink(
            height: 190,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: d.colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -24,
                  top: -8,
                  child: Icon(d.icon, size: 160, color: Colors.white24),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: FavButton(d.id, color: Colors.white),
                ),
                Positioned(
                  left: 18,
                  right: 18,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        d.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.place, size: 16, color: Colors.white70),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              d.location,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                          const Icon(Icons.star, size: 16, color: matahari),
                          const SizedBox(width: 2),
                          Text(
                            '${d.rating}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Perkiraan ${rupiah(d.price)} / orang',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FavButton extends StatelessWidget {
  const FavButton(this.id, {super.key, this.color});
  final int id;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final fav = store.isFav(id);
        return IconButton(
          tooltip: fav ? 'Hapus dari favorit' : 'Simpan ke favorit',
          onPressed: () => store.toggleFav(id),
          icon: Icon(
            fav ? Icons.favorite : Icons.favorite_border,
            color: fav ? Colors.redAccent.shade100 : color,
          ),
        );
      },
    );
  }
}

// -------------------------------- Detail -----------------------------------

class DetailPage extends StatelessWidget {
  const DetailPage(this.d, {super.key});
  final Destination d;

  void _openPlan(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => PlanSheet(d),
    );
  }

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 8),
        child: Text(
          t,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: tinta),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            foregroundColor: Colors.white,
            backgroundColor: d.colors.first,
            actions: [FavButton(d.id, color: Colors.white)],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(d.name),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: d.colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, top: 24),
                    child: Icon(d.icon, size: 170, color: Colors.white24),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.place, size: 18, color: hijau),
                      const SizedBox(width: 4),
                      Expanded(child: Text(d.location)),
                      const Icon(Icons.star, size: 18, color: matahari),
                      const SizedBox(width: 2),
                      Text(
                        '${d.rating}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(d.description, style: const TextStyle(height: 1.5, fontSize: 15)),
                  _title('Yang bisa dilakukan'),
                  for (final h in d.highlights)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle, size: 20, color: hijau),
                          const SizedBox(width: 10),
                          Expanded(child: Text(h)),
                        ],
                      ),
                    ),
                  _title('Fasilitas'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [for (final f in d.facilities) Chip(label: Text(f))],
                  ),
                  _title('Waktu terbaik'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.schedule, size: 20, color: matahari),
                      const SizedBox(width: 10),
                      Expanded(child: Text(d.bestTime)),
                    ],
                  ),
                  _title('Tips'),
                  for (final t in d.tips)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.lightbulb_outline, size: 20, color: matahari),
                          const SizedBox(width: 10),
                          Expanded(child: Text(t)),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  const Text(
                    'Biaya hanya perkiraan dan bisa berubah. Cek ke pengelola sebelum berangkat.',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black12)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rupiah(d.price),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    const Text('perkiraan per orang', style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () => _openPlan(context),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(170, 48),
                  backgroundColor: hijau,
                ),
                child: const Text('Rencanakan kunjungan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanSheet extends StatefulWidget {
  const PlanSheet(this.d, {super.key});
  final Destination d;

  @override
  State<PlanSheet> createState() => _PlanSheetState();
}

class _PlanSheetState extends State<PlanSheet> {
  DateTime date = DateTime.now().add(const Duration(days: 7));
  int people = 2;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => date = picked);
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.d.price * people;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rencana ke ${widget.d.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event, color: hijau),
            title: const Text('Tanggal berkunjung'),
            subtitle: Text(tanggal(date)),
            trailing: TextButton(onPressed: _pickDate, child: const Text('Ubah')),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.group, color: hijau),
            title: const Text('Jumlah orang'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: people > 1 ? () => setState(() => people--) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$people', style: const TextStyle(fontSize: 16)),
                IconButton(
                  onPressed: people < 20 ? () => setState(() => people++) : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Perkiraan total'),
              Text(
                rupiah(total),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: hijau,
              ),
              onPressed: () {
                final messenger = ScaffoldMessenger.of(context);
                store.book(Booking(widget.d, date, people));
                Navigator.pop(context);
                messenger.showSnackBar(
                  SnackBar(content: Text('Rencana ke ${widget.d.name} disimpan.')),
                );
              },
              child: const Text('Simpan rencana'),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------- Favorit -----------------------------------

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final list = destinations.where((d) => store.isFav(d.id)).toList();
    return SafeArea(
      child: list.isEmpty
          ? const EmptyState(
              icon: Icons.favorite_border,
              text: 'Belum ada favorit.\nKetuk ikon hati pada destinasi untuk menyimpannya.',
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                const Text(
                  'Favorit',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: tinta),
                ),
                const SizedBox(height: 16),
                for (final d in list) DestinationCard(d),
              ],
            ),
    );
  }
}

// -------------------------------- Rencana ----------------------------------

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final list = store.bookings;
    return SafeArea(
      child: list.isEmpty
          ? const EmptyState(
              icon: Icons.event_note_outlined,
              text: 'Belum ada rencana.\nPilih destinasi, lalu ketuk Rencanakan kunjungan.',
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                const Text(
                  'Rencana saya',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: tinta),
                ),
                const SizedBox(height: 16),
                for (final b in list)
                  Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(14),
                      leading: CircleAvatar(
                        backgroundColor: b.dest.colors.first,
                        child: Icon(b.dest.icon, color: Colors.white),
                      ),
                      title: Text(
                        b.dest.name,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        '${tanggal(b.date)}\n${b.people} orang, perkiraan ${rupiah(b.total)}',
                      ),
                      isThreeLine: true,
                      trailing: TextButton(
                        onPressed: () => store.cancel(b),
                        child: const Text('Hapus'),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Colors.black26),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
