import 'package:flutter/material.dart';
import 'package:thebookest/models/CartItem.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItem(int iId, String iTitle, int iPrice, int iQuantity) {
    bool isExist = false;

    CartItem item =
        CartItem(id: iId, title: iTitle, price: iPrice, quantity: iQuantity);
    // id: 1,
    // title: "Chú Thuật Hồi Chiến - Tập 6",
    // price: 27100,
    // quantity: 1);
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].id == iId) {
        _cartItems[i].quantity += iQuantity;
        isExist = true;
        break;
      }
    }
    if (!isExist) {
      _cartItems.add(item);
    }
    _cartItems.forEach((element) => print(element.title));
    notifyListeners();
    // // Thêm thông báo thành công
    // final snackBar =
    //     SnackBar(content: Text('Sản phẩm đã được thêm vào giỏ hàng'));
    // ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
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
}
