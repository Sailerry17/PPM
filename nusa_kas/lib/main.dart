import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/transaksi_repository.dart';
import 'domain/kas_calculator.dart';
import 'ui/kas/kas_view_model.dart';
import 'ui/kas/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => KasViewModel(TransaksiRepository(), KasCalculator()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaKas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
