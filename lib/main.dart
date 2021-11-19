import 'package:flutter/material.dart';
import 'package:myshop_app/providers/cart.dart';
import 'package:myshop_app/providers/orders.dart';
import 'package:myshop_app/providers/products_provider.dart';
import 'package:myshop_app/screens/cart_screen.dart';
import 'package:myshop_app/screens/orders_screen.dart';
import 'package:provider/provider.dart';

import 'package:myshop_app/screens/product_detail_screen.dart';
import 'package:myshop_app/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}