import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/cart.dart';
import 'package:shop2/utils/app_routes.dart';
import '../models/product.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

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
            // fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Container(
            // decoration: BoxDecoration(
            //   border: Border.symmetric(
            //     vertical:
            //   ),
            // ),
            child: Text(
              product.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  // fontSize: 10,
                  ),
            ),
          ),
          backgroundColor: Color.fromARGB(221, 27, 27, 27),
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
                onPressed: () => product.toogleFavorite(),
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary,
                  // size: 20,
                ),
                alignment: Alignment.center),
          ),
          trailing: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Produto adicionado com sucesso"),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "DESFAZER",
                    onPressed: () {
                      cart.removeSingleitem(product.id);
                    },
                  ),
                ),
              );
              cart.addItem(product);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
              // size: 20,
            ),
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
