import 'package:flutter/material.dart';

class CartItem {
  final String product;
  final int price;
  int quantity;

  CartItem(
      {required this.product, required this.price, required this.quantity});
}

List<CartItem> cartItems = [
  CartItem(product: "Chú Thuật Hồi Chiến - Tập 6", price: 27100, quantity: 1),
];
