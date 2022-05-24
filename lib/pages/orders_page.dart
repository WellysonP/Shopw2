import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/components/app_drawer.dart';
import 'package:shop2/components/order.dart';
import 'package:shop2/models/order_list.dart';

class OrdersPages extends StatefulWidget {
  const OrdersPages({Key? key}) : super(key: key);

  @override
  State<OrdersPages> createState() => _OrdersPagesState();
}

class _OrdersPagesState extends State<OrdersPages> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders().then((_) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orders.items.length,
              itemBuilder: (ctx, index) => OrderWidget(
                order: orders.items[index],
              ),
            ),
    );
  }
}
