import 'package:shop2/models/cart_item.dart';
import 'package:shop2/models/product.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;
  final String? imageUrl;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
    this.imageUrl,
  });
}
