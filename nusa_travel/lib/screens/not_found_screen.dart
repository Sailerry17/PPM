import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class NotFoundScreen extends StatelessWidget {
  final String? routeName;
  const NotFoundScreen({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error 404')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline,
                  size: 96, color: Colors.redAccent),
              const SizedBox(height: 16),
              const Text('404',
                  style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Halaman tidak ditemukan',
                  style: TextStyle(fontSize: 18)),
              if (routeName != null) ...[
                const SizedBox(height: 8),
                Text('Route: $routeName',
                    style: TextStyle(color: Colors.grey[600])),
              ],
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.home, (route) => false),
                icon: const Icon(Icons.home),
                label: const Text('Kembali ke Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
