import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop2/models/cart_item.dart';
import '../utils/constants.dart';
import 'cart.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final cartProducts = cart.items.values.map((cartItem) => {
          "id": cartItem.id,
          "productId": cartItem.productId,
          "name": cartItem.name,
          "quantity": cartItem.quantity,
          "price": cartItem.price,
        });
    final response = await http.post(
      Uri.parse("${Constants.ORDERS_BASE_URL}.json"),
      body: jsonEncode(
        {
          "total": cart.totalAmount,
          "date": date.toIso8601String(),
          "products": cartProducts.toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)["name"];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }

  Future<void> loadOrders() async {
    _items.clear();
    final response = await http.get(
      Uri.parse("${Constants.ORDERS_BASE_URL}.json"),
    );
    if (response.body == "null") return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      _items.add(
        Order(
          id: orderId,
          date: DateTime.parse(orderData["date"]),
          total: orderData["total"],
          products: (orderData["products"] as List<dynamic>).map((item) {
            return CartItem(
              id: item["id"],
              productId: item["productId"],
              name: item["name"],
              quantity: item["quantity"],
              price: item["price"],
            );
          }).toList(),
        ),
      );
    });
    notifyListeners();
  }
}
