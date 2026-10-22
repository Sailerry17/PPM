import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.primary, color.primaryContainer],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.travel_explore,
                      size: 80, color: color.primary),
                ),
                const SizedBox(height: 24),
                const Text(
                  'NusaTravel',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Jelajahi keindahan Nusantara',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 48),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: color.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                  child: const Text('Mulai Eksplorasi',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
