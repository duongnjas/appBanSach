import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:thebookest/constants.dart';
import 'package:thebookest/screens/cart/cart.dart';
import 'package:thebookest/screens/cart/provider/cart_provider.dart';
import 'package:thebookest/screens/home/components/body.dart';
import 'package:thebookest/screens/sidebar/sidebar.dart';
import 'package:thebookest/models/Product.dart';
import 'package:thebookest/screens/search/searchpage.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> productList = products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/user.svg"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SideBar()),
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {
            showSearch(
              context: context,
              delegate: ProductSearchDelegate(productList),
            );
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CartScreen(
                      product: Product(
                          id: 0,
                          title: "",
                          description: "",
                          quantity: 0,
                          price: 0,
                          image: "",
                          color: Colors.black))),
            );
          },
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}

class ProductSearchDelegate extends SearchDelegate<String> {
  final List<Product> listProduct;
  ProductSearchDelegate(this.listProduct);
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: theme.canvasColor,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      textTheme: theme.textTheme.copyWith(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Product> searchResults = products
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SearchResultsScreen(searchResults: searchResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
