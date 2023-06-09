import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thebookest/constants.dart';
import 'package:thebookest/models/Product.dart';
import 'package:thebookest/screens/cart/provider/cart_provider.dart';
import 'package:thebookest/screens/details/components/body.dart';
import 'package:provider/provider.dart';
import 'package:thebookest/screens/cart/cart.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: CartProvider()),
        ],
        child: Scaffold(
          // each product have a color
          backgroundColor: product.color,
          appBar: buildAppBar(context),
          body: Body(product: product),
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        // IconButton(
        //   icon: SvgPicture.asset("assets/icons/search.svg"),
        //   onPressed: () {},
        // ),
        // IconButton(
        //   icon: SvgPicture.asset("assets/icons/cart.svg"),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => CartScreen()),
        //     );
        //   },
        // ),
        const SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
