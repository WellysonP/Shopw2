import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/product_list.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import '../components/product_item.dart';

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> loadedProducts =
        Provider.of<ProductList>(context).items;
    // final provider = Provider.of<ProductList>(context);
    // final List<Product> loadedProducts = provider.items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Lojinhas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: loadedProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, index) =>
              ProductItem(product: loadedProducts[index]),
        ),
      ),
    );
  }
}
