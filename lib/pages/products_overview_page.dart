import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/product_list.dart';
import '../components/product_grid.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import '../components/product_item.dart';

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lojinhas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductGrid(),
      ),
    );
  }
}
