import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:myshop_app/widgets/badge.dart';
import 'package:myshop_app/providers/cart.dart';
import 'package:myshop_app/providers/products_provider.dart';
import 'package:myshop_app/screens/cart_screen.dart';

import 'package:myshop_app/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('MyShop'), actions: <Widget>[
        PopupMenuButton(
          onSelected: (FilterOptions selectedValue) {
            setState(() {
              _showOnlyFavorites = (selectedValue == FilterOptions.Favorites);
            });
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
                child: Text('Only Favorites'), value: FilterOptions.Favorites),
            PopupMenuItem(child: Text('Show all'), value: FilterOptions.All)
          ],
        ),
        Consumer<Cart>(
          builder: (_, cartData, ch) => Badge(
            child: ch as Widget,
            value: cartData.itemCount.toString(),
          ),
          child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        )
      ]),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
