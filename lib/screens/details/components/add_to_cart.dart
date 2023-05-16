import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thebookest/models/Product.dart';
import 'package:thebookest/models/CartItem.dart';
import 'package:thebookest/screens/cart/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
    required this.product,
    required this.cartProvider,
  }) : super(key: key);

  final Product product;
  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: product.color,
              ),
            ),
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) => IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/add_to_cart.svg",
                  color: product.color,
                ),
                onPressed: () {
                  cartProvider.addItem(
                    CartItem(
                      product: product.title,
                      price: product.price,
                      quantity: 1,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: product.color,
                ),
                onPressed: () {},
                child: Text(
                  "Buy Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
