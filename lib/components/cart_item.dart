import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/cart.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget(this.cartItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              "EXCLUIR",
              style: TextStyle(color: Colors.red),
            ),
            content: const Text("Deseja excluir o item do carrinho?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text("Sim"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text("Não"),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(cartItem.imageUrl),
          ),
          title: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 5, bottom: 10),
              child: Text(
                cartItem.name,
                style: TextStyle(fontSize: 17),
              )),
          subtitle: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 138, 138, 138),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 30,
                  child: IconButton(
                    onPressed: () {
                      cart.removeSingleitem(cartItem.productId);
                    },
                    icon: Icon(
                      Icons.remove,
                      size: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("${cartItem.quantity} x R\$ " +
                      NumberFormat.currency(
                              locale: "pt", customPattern: "#,###.#")
                          .format(cartItem.price)),
                ),
                Container(
                  width: 30,
                  child: IconButton(
                    onPressed: () {
                      cart.addSingleitem(cartItem.productId);
                    },
                    icon: Icon(
                      Icons.add,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              "R\$ " +
                  NumberFormat.currency(locale: "pt", customPattern: "#,###.#")
                      .format(cartItem.price * cartItem.quantity),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                // color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
