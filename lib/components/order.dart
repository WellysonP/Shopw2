import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            title: Text("R\$ " +
                NumberFormat.currency(locale: "pt", customPattern: "#,###.#")
                    .format(widget.order.total)),
            subtitle:
                Text(DateFormat("dd/MM/yy hh:mm").format(widget.order.date)),
            trailing: const Icon(Icons.expand_more),
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: (widget.order.products.length * 55) + 10,
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          widget.order.products.elementAt(i).imageUrl)),
                  title: Text(
                    widget.order.products.elementAt(i).name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "${widget.order.products.elementAt(i).quantity}x R\$ " +
                        NumberFormat.currency(
                                locale: "pt", customPattern: "#,###.#")
                            .format(widget.order.products.elementAt(i).price),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
