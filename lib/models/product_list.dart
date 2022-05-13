import 'package:flutter/cupertino.dart';
import 'package:shop2/data/dummy_data.dart';
import 'package:shop2/models/product.dart';

class ProductList with ChangeNotifier {
  //mixins
  List<Product> _items = dummyProducts;
  bool _showFavoriteOnly = false;

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  List<Product> get items {
    if (_showFavoriteOnly) {
      return _items.where((element) => element.isFavorite).toList();
    }
    return [..._items];
  } //usado para clonar a referência

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); //provider notificador
  }
}
