import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../exceptions/http_exceptions.dart';
import '../utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _toogleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toogleFavorite(String token, String userId) async {
    _toogleFavorite();

    final response = await http.put(
      Uri.parse("${Constants.USER_FAVORITES_URL}/$userId/$id.json?auth=$token"),
      body: jsonEncode(isFavorite),
    );

    if (response.statusCode >= 400) {
      _toogleFavorite();

      throw HttpException(
          msg: "Não foi possível favoritar o produto.",
          statusCode: response.statusCode);
    }
  }
}
