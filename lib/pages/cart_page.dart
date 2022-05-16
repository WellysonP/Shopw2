import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/cart_item.dart';
import 'package:shop2/models/order_list.dart';
import '../models/cart.dart';
import '../components/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho de compras"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      "R\$ ${cart.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderList>(
                        context,
                        listen: false,
                      ).addOrder(cart);

                      cart.clearCart();
                    },
                    child: Text("COMPRAR"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) => CartItemWidget(items[index]),
            ),
          )
        ],
      ),
    );
  }
}
