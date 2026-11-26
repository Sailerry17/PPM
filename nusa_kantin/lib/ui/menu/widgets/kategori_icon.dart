import 'package:flutter/material.dart';

/// Ikon sederhana per kategori (pengganti foto menu).
IconData iconForKategori(String kategori) => switch (kategori) {
      'Makanan' => Icons.restaurant,
      'Minuman' => Icons.local_cafe,
      'Camilan' => Icons.fastfood,
      _ => Icons.restaurant_menu,
    };
