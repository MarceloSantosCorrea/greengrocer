import 'package:flutter/material.dart';
import '../../config/app_data.dart' as app_data;
import 'components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => OrderTile(
          order: app_data.orders[index],
        ),
        itemCount: app_data.orders.length,
        separatorBuilder: (_, index) => const SizedBox(height: 10),
      ),
    );
  }
}
