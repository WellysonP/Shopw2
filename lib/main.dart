import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/product_list.dart';
import 'package:shop2/pages/product_detail_page.dart';
import 'package:shop2/utils/app_routes.dart';
import './pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      fontFamily: "Lato",
    );
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: ProductsOverviewPage(),
        routes: {AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailPage()},
      ),
    );
  }
}
