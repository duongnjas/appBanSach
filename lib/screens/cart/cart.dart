import 'package:flutter/material.dart';
import 'package:thebookest/models/CartItem.dart';
import 'package:thebookest/models/Product.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Product> productsInCart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: productsInCart.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = productsInCart[index];
          return ListTile(
            title: Text(product.title),
            trailing: Text("\$${product.price}"),
          );
        },
      ),
    );
  }
}
