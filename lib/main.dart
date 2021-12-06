import 'package:flutter/material.dart';
import 'package:myshop_app/providers/auth.dart';
import 'package:myshop_app/providers/cart.dart';
import 'package:myshop_app/providers/orders.dart';
import 'package:myshop_app/providers/products_provider.dart';
import 'package:myshop_app/screens/auth_screen.dart';
import 'package:myshop_app/screens/cart_screen.dart';
import 'package:myshop_app/screens/edit_product_screen.dart';
import 'package:myshop_app/screens/orders_screen.dart';
import 'package:myshop_app/screens/splash_screen.dart';
import 'package:myshop_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

import 'package:myshop_app/screens/product_detail_screen.dart';
import 'package:myshop_app/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        // ChangeNotifierProxyProvider<Auth, Products>(
        //   update: (ctx, auth, previousProducts) => Products(auth.token!,
        //       previousProducts == null ? [] : previousProducts.items),
        //   create: (ctx) => Products(null, []),
        // ),
        ChangeNotifierProxyProvider<Auth, Products?>(
          create: (ctx) => Products(null, null, []),
          update: (ctx, auth, previousProduct) => Products(
              auth.token,
              auth.userId,
              previousProduct == null ? [] : previousProduct.items),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        // ChangeNotifierProvider(create: (ctx) => Orders()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(null, null, []),
          update: (ctx, auth, previousOrders) => Orders(auth.token, auth.userId,
              previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
