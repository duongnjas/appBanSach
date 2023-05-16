import 'package:flutter/material.dart';
import 'package:thebookest/models/CartItem.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [
    CartItem(product: "Chú Thuật Hồi Chiến - Tập 6", price: 27100, quantity: 1),
    CartItem(product: "Blue Period - Tập 01", price: 23000, quantity: 2),
  ];

  List<CartItem> get cartItems => _cartItems;

  void addItem(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  int get checkCart {
    return _cartItems.length;
  }

  void updateItem(CartItem item, int quantity) {
    item.quantity = quantity;
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    _cartItems.forEach((item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void addItemToCart(CartItem cartItem) {}
}
