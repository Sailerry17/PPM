import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _logout(BuildContext context) {
    // Hapus seluruh riwayat halaman, kembali ke Splash.
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.splash,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final packages = TourPackage.dummyData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paket Wisata'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Tes halaman 404',
            icon: const Icon(Icons.bug_report_outlined),
            onPressed: () => Navigator.pushNamed(context, '/halaman-tidak-ada'),
          ),
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final pkg = packages[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(bottom: 14),
            elevation: 3,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.detail,
                  arguments: pkg,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: PackageImage(url: pkg.imageUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pkg.title,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(
                          pkg.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pkg.formattedPrice,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Gambar jaringan dengan fallback jika gagal dimuat / offline.
class PackageImage extends StatelessWidget {
  final String url;
  const PackageImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stack) => Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: const Center(
          child: Icon(Icons.landscape, size: 56, color: Colors.white),
        ),
      ),
    );
  }
}
