import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shop2/components/is_dark_theme.dart';
import 'package:shop2/firebase_options.dart';
import 'package:shop2/models/auth.dart';
import 'package:shop2/models/cart.dart';
import 'package:shop2/models/order_list.dart';
import 'package:shop2/models/product_list.dart';
import 'package:shop2/pages/auth_or_home_page.dart';
import 'package:shop2/pages/orders_page.dart';
import 'package:shop2/pages/product_detail_page.dart';
import 'package:shop2/pages/products_page.dart';
import 'package:shop2/utils/app_routes.dart';
import './pages/cart_page.dart';
import './pages/product_form_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  FirebaseFirestore.instance
      .collection("Pedidos")
      .doc("01")
      .snapshots()
      .listen((document) {
    print(document["usuário"]);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //Utilizado para vários providers
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previus) {
            return ProductList(
              auth.token ?? "",
              auth.userId ?? "",
              previus?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
            create: (_) => OrderList(),
            update: (ctx, auth, previus) {
              return OrderList(
                auth.token ?? "",
                auth.userId ?? "",
                previus?.items ?? [],
              );
            }),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => IsADarkTheme(),
        )
      ], //modificação para utilizar o MultiPovider
      child: Consumer<IsADarkTheme>(builder: (ctx, provider, child) {
        return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [const Locale('pt', 'BR')],
          // final ThemeData theme = ThemeData();
          theme: provider.themeData.copyWith(
            colorScheme: provider.themeData.colorScheme.copyWith(
              primary: Colors.red,
              secondary: Colors.deepOrange,
            ),
            textTheme: provider.themeData.textTheme.copyWith(
              headline6: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            AppRoutes.AUTH_OR_HOME: (context) => const AuthOrHomePage(),
            AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
            AppRoutes.CART: (context) => const CartPage(),
            AppRoutes.ORDERS: (context) => const OrdersPages(),
            AppRoutes.PRODUCTS: (context) => const ProductsPage(),
            AppRoutes.PRODUCT_FORM: (context) => const ProductFormPage(),
          },
        );
      }),
    );
  }
}
