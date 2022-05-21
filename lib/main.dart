import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/auth.dart';
import 'package:shop2/models/cart.dart';
import 'package:shop2/models/order_list.dart';
import 'package:shop2/models/product_list.dart';
import 'package:shop2/pages/auth_or_home_page.dart';
import 'package:shop2/pages/auth_page.dart';
import 'package:shop2/pages/orders_page.dart';
import 'package:shop2/pages/product_detail_page.dart';
import 'package:shop2/pages/products_page.dart';
import 'package:shop2/utils/app_routes.dart';
import './pages/products_overview_page.dart';
import './pages/cart_page.dart';
import './pages/product_form_page.dart';

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
    return MultiProvider(
      //Utilizado para vários providers
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ], //modificação para utilizar o MultiPovider
      child: MaterialApp(
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          textTheme: theme.textTheme.copyWith(
            headline6: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.AUTH_OR_HOME: (context) => AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailPage(),
          AppRoutes.CART: (context) => CartPage(),
          AppRoutes.ORDERS: (context) => OrdersPages(),
          AppRoutes.PRODUCTS: (context) => ProductsPage(),
          AppRoutes.PRODUCT_FORM: (context) => ProductFormPage(),
        },
      ),
    );
  }
}
