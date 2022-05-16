import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop2/components/app_drawer.dart';
import 'package:shop2/components/order.dart';
import 'package:shop2/models/order.dart';
import 'package:shop2/models/order_list.dart';

class OrdersPages extends StatelessWidget {
  const OrdersPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (ctx, index) => OrderWidget(
          order: orders.items[index],
        ),
      ),
    );
  }
}
