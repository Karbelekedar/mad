import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String price;

  CartItem({required this.id, required this.name, required this.price});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  double get totalAmount {
    double total = 0;
    for (var item in _cartItems) {
      total += double.parse(item.price);
    }
    return total;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
