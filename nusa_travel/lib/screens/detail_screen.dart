import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import 'booking_screen.dart';
import 'home_screen.dart' show PackageImage;

class DetailScreen extends StatelessWidget {
  final TourPackage tourPackage;
  const DetailScreen({super.key, required this.tourPackage});

  Future<void> _openBooking(BuildContext context) async {
    final result = await Navigator.push<BookingResult>(
      context,
      MaterialPageRoute(
        builder: (_) => BookingScreen(tourPackage: tourPackage),
      ),
    );

    if (result != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green[700],
          content: Text(
            'Pemesanan berhasil! ${result.name}, ${result.participants} peserta, '
            '${result.formattedDate}. Total ${formatRupiah(result.totalPrice)}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Paket')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 230,
              width: double.infinity,
              child: PackageImage(url: tourPackage.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tourPackage.title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    '${tourPackage.formattedPrice} / orang',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Divider(height: 32),
                  const Text('Deskripsi',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(tourPackage.description,
                      style: const TextStyle(fontSize: 15, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14)),
            onPressed: () => _openBooking(context),
            icon: const Icon(Icons.shopping_cart_checkout),
            label: const Text('Pesan Sekarang'),
          ),
        ),
      ),
    );
  }
}
