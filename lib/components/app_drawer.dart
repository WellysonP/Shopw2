import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/components/is_dark_theme.dart';
import 'package:shop2/utils/app_routes.dart';
import '../models/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<IsADarkTheme>(context);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Menu"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Lista de Produtos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.AUTH_OR_HOME,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Pedidos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.ORDERS,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Gerenciar Produtos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.PRODUCTS,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: darkTheme.isDark
                ? const Icon(Icons.sunny)
                : const Icon(Icons.mode_night),
            title: darkTheme.isDark ? Text("Tema Claro") : Text("Tema Escuro"),
            onTap: () => darkTheme.changeTheme(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Sair do aplicativo"),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).restorablePushNamed(
                AppRoutes.AUTH_OR_HOME,
              );
            },
          ),
        ],
      ),
    );
  }
}
