import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<Cart> cartlist = [];
  double cartprice = 0.00;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    await cartService.refresh();
    debugPrint(cartService.items.toJson().toString());
    setState(() {
      cartlist = cartService.items;
      cartprice = cartService.items.fold(0.0, (sum, item) => sum + item.totalPrice);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ...cartlist.map((cart) {
              return Dismissible(
                key: Key("cart${cart.id.toString()}"),
                confirmDismiss: (_) async {
                  try {
                    await client.cart.deleteCart(cart.id!);
                    await _loadCart();
                    return true;
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                    return false;
                  }
                },
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  title: Text(cart.id.toString()),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
