import 'package:flutter/foundation.dart';
import '../models/book.dart';

class CartItem {
  final Book book;
  int quantity;

  CartItem({required this.book, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(Book book) {
    final index = _items.indexWhere((item) => item.book.id == book.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(book: book));
    }
    notifyListeners();
  }

  void removeItem(Book book) {
    final index = _items.indexWhere((item) => item.book.id == book.id);
    if (index < 0) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get totalItems =>
      _items.fold(0, (total, item) => total + item.quantity);

  int get totalPrice => _items.fold(
        0,
        (total, item) => total + item.book.price * item.quantity,
      );
}
