import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/auth.dart';
import 'package:shop2/utils/app_routes.dart';
import '../exceptions/http_exceptions.dart';
import '../models/product.dart';
import 'package:intl/intl.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    final product = Provider.of<Product>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

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
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage("assets/images/fitment-loader.gif"),
              image: NetworkImage(product.imageUrl),
            ),
          ),
          // child: Image.network(
          //   product.imageUrl,
          // ),
        ),
        footer: Container(
          height: 50,
          child: GridTileBar(
            title: Text(
              product.name,
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            backgroundColor: Color.fromARGB(221, 53, 53, 53),
            subtitle: Text("R\$ " +
                NumberFormat.currency(locale: "pt", customPattern: "#,###.#")
                    .format(product.price)),
            trailing: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                  onPressed: () async {
                    try {
                      await product.toogleFavorite(
                        auth.token ?? "",
                        auth.userId ?? "",
                      );
                    } on HttpException catch (error) {
                      msg.showSnackBar(
                        SnackBar(
                          content: Text(error.msg),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  alignment: Alignment.center),
            ),
          ),
        ),
      ),
    );
  }
}
