import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      body: cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.remove_shopping_cart_outlined,
                      size: 72, color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(height: 12),
                  const Text('Keranjang masih kosong'),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.menu_book),
                    label: const Text('Lihat Katalog'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 54,
                                height: 68,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.menu_book,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.book.title,
                                        style: const TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(rupiah(item.book.price)),
                                    const SizedBox(height: 8),
                                    Text('Subtotal: ${rupiah(item.book.price * item.quantity)}'),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton.filledTonal(
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () => context
                                        .read<CartProvider>()
                                        .removeItem(item.book),
                                    icon: const Icon(Icons.remove, size: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text('${item.quantity}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 16)),
                                  ),
                                  IconButton.filledTonal(
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () => context
                                        .read<CartProvider>()
                                        .addItem(item.book),
                                    icon: const Icon(Icons.add, size: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Card(
                    margin: const EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Consumer<CartProvider>(
                            builder: (context, cartState, _) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total Item'),
                                Text('${cartState.totalItems}',
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Pembayaran',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                rupiah(cart.totalPrice),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: cart.totalItems == 0
                                  ? null
                                  : () {
                                      final total = rupiah(
                                          context.read<CartProvider>().totalPrice);
                                      context.read<CartProvider>().clearCart();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Checkout berhasil! Total pembayaran $total.'),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                              icon: const Icon(Icons.payment),
                              label: const Text('Checkout / Bayar'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
