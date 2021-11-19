import 'package:flutter/material.dart';
import 'package:myshop_app/providers/orders.dart';
import 'package:myshop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart' as oi;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, index) => oi.OrderItem(orderData.orders[index])),
    );
  }
}
