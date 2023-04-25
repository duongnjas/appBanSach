import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebookest/screens/cart/provider/cart_provider.dart';
import 'package:thebookest/screens/cart/order_success.dart';
import 'package:thebookest/models/CartItem.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Giỏ hàng',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green[700],
        ),
        body: Consumer<CartProvider>(
          builder: (context, cartItem, child) {
            if (cartItem.checkCart == 0) {
              return Center(
                child: Text(
                  'Giỏ hàng trống',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItem.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItem.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(item.quantity.toString()),
                            backgroundColor: Colors.green[700],
                            foregroundColor: Colors.white,
                          ),
                          title: Text(
                            item.product,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${item.price}đ',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => cartItem.removeItem(item),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng tiền:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${cartItem.totalPrice}đ',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderSuccessScreen()),
                      );
                    },
                    child: Text(
                      'Đặt hàng',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[700],
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
