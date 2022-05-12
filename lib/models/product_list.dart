import 'package:flutter/cupertino.dart';
import 'package:shop2/data/dummy_data.dart';
import 'package:shop2/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items]; //usado para clonar a referência

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
