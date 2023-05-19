import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final int price, id;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

List<CartItem> cartItems = [
  CartItem(
      id: 1, title: "Chú Thuật Hồi Chiến - Tập 6", price: 27100, quantity: 1),
  CartItem(id: 2, title: "Blue Period - Tập 01", price: 23000, quantity: 1),
  CartItem(
      id: 3,
      title: "Toàn Thư Chiêm Tinh Học Nhập Môn",
      price: 52000,
      quantity: 1),
  CartItem(id: 4, title: "Yêu nhưng không hoàn hảo", price: 45000, quantity: 1),
  CartItem(id: 5, title: "Thao Túng Tâm Lý", price: 200000, quantity: 1),
  CartItem(id: 6, title: "Điềm tĩnh và nóng giận", price: 150000, quantity: 1),
];
// List<CartItem> cartItems = [
//   CartItem(id: 1, title: "Chú Thuật Hồi Chiến - Tập 6", price: 27100,),
//   CartItem(id: 2, title: "Blue Period - Tập 01", price: 23000,),
//   CartItem(id: 3,title: "Toàn Thư Chiêm Tinh Học Nhập Môn",price: 52000,),
//   CartItem(id: 4, title: "Yêu nhưng không hoàn hảo", price: 45000,),
//   CartItem(id: 5, title: "Thao Túng Tâm Lý", price: 200000,),
//   CartItem(id: 6, title: "Điềm tĩnh và nóng giận", price: 150000, ),
//];
