import 'package:flutter/material.dart';
import 'package:shop2/utils/app_routes.dart';
import '../models/product.dart';
import '../pages/product_detail_page.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.secondary,
              ),
              alignment: Alignment.centerLeft),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
            alignment: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}
