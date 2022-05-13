import 'package:flutter/material.dart';
import '../components/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewPage extends StatefulWidget {
  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Produtos"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_horiz),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Somente Favoritos"),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text("Todos Produtos"),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          )
        ],
      ),
      body: ProductGrid(showfavoriteOnly: _showFavoriteOnly),
    );
  }
}
