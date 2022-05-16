import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop2/models/product.dart';
import 'cart.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  List<Order> _itesm = [];

  List<Order> get items {
    return [..._itesm];
  }

  int get itemsCount {
    return _itesm.length;
  }

  void addOrder(Cart cart) {
    _itesm.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
