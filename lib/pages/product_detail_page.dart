import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../components/badge.dart';
import '../models/cart.dart';
import '../models/product.dart';
import '../utils/app_routes.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Color.fromARGB(221, 53, 53, 53),
                content: const Text(
                  "Produto adicionado com sucesso",
                  style: TextStyle(color: Colors.white),
                ),
                duration: const Duration(seconds: 2),
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
          child: Container(
            height: 60,
            alignment: Alignment.center,
            color: Color.fromRGBO(0, 174, 124, 1),
            child: Text(
              "ADICIONAR AO CARRINHO",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.countItems.toString(),
              child: child!,
            ),
          ),
        ],
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "R\$ " +
                  NumberFormat.currency(locale: "pt", customPattern: "#,###.#")
                      .format(product.price),
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Lato",
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(product.description),
            )
          ],
        ),
      ),
    );
  }
}
