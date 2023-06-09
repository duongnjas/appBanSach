import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebookest/screens/cart/provider/cart_provider.dart';
import 'package:thebookest/screens/cart/order_success.dart';
import 'package:thebookest/models/CartItem.dart';
import 'package:thebookest/screens/cart/payment.dart';
import 'package:thebookest/models/Product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: CartProvider(),
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
            if (product.id == 0) {
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(product!.quantity.toString()),
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                      ),
                      title: Text(
                        product!.title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${product.price}đ',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => {},
                      ),
                    ),
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
                        '${product!.price}đ',
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
                            builder: (context) =>
                                CheckoutScreen(product: product)),
                      );
                    },
                    child: Text(
                      'Xác Nhận',
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
