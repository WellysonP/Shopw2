import 'package:flutter/material.dart';
import 'package:shop2/models/cart_item.dart';
import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho de compras"),
      ),
    );
  }
}
