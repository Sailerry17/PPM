import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  static const List<Book> books = [
    Book(id: 'b1', title: 'Laskar Pelangi', author: 'Andrea Hirata', price: 85000),
    Book(id: 'b2', title: 'Bumi', author: 'Tere Liye', price: 92000),
    Book(id: 'b3', title: 'Filosofi Teras', author: 'Henry Manampiring', price: 98000),
    Book(id: 'b4', title: 'Atomic Habits', author: 'James Clear', price: 115000),
    Book(id: 'b5', title: 'Negeri 5 Menara', author: 'Ahmad Fuadi', price: 78000),
    Book(id: 'b6', title: 'The Psychology of Money', author: 'Morgan Housel', price: 105000),
  ];

  String rupiah(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      final remaining = digits.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) buffer.write('.');
    }
    return 'Rp${buffer.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().totalItems;
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.menu_book_rounded),
            SizedBox(width: 8),
            Text('NusaBookstore'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: isDark ? 'Aktifkan Light Mode' : 'Aktifkan Dark Mode',
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
          IconButton(
            tooltip: 'Keranjang belanja',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined, size: 27),
                if (cartCount > 0)
                  Positioned(
                    right: -9,
                    top: -8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(minWidth: 19, minHeight: 19),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$cartCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Temukan Bacaan Favoritmu',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          const SizedBox(height: 6),
          Text('Pilihan buku untuk menemani waktu dan menambah wawasan.'),
          const SizedBox(height: 18),
          ...books.map((book) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 76,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: book.imageUrl == null
                            ? Icon(Icons.menu_book_rounded,
                                size: 42,
                                color: Theme.of(context).colorScheme.onPrimaryContainer)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(book.imageUrl!, fit: BoxFit.cover),
                              ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(book.title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(book.author,
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(height: 8),
                            Text(rupiah(book.price),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                )),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: () {
                                  context.read<CartProvider>().addItem(book);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${book.title} ditambahkan ke keranjang'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add_shopping_cart, size: 18),
                                label: const Text('Tambah ke Keranjang'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
