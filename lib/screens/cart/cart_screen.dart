import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learning/provider/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool showCoupon = true;

  @override
  Widget build(BuildContext context) {
    final cartProducts = ref.watch(cartNotifierProvider);
    final notifer = ref.read(cartNotifierProvider
        .notifier); // here we used .notifer beacuse we want to access the methods
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
        actions: [
          if (notifer.sorted)
            IconButton(
                onPressed: () {
                  notifer.sortByPriceASC();
                  notifer.changeProductDESC(false);
                },
                icon: const Icon(CupertinoIcons.chevron_down)),
          if (!notifer.sorted)
            IconButton(
                onPressed: () {
                  notifer.sortByPriceDESC();
                  notifer.changeProductDESC(true);
                },
                icon: const Icon(CupertinoIcons.chevron_up))
        ],
      ),
      body: Container(
        height: double.infinity,
        padding:
            const EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 15),
        child: Column(
          children: [
            Column(
                children: cartProducts.map((product) {
              return Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Image.asset(
                      product.image,
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(width: 10),
                    Text('${product.title}...'),
                    const Expanded(child: SizedBox()),
                    Text('\$${product.price}'),
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {
                          notifer.removeProduct(product);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        )),
                  ],
                ),
              );
            }).toList()),
            const SizedBox(height: 50),
            // output totals here
            Center(
                child: Text("Total Price - $total\$",
                    style: const TextStyle(fontSize: 25)))
          ],
        ),
      ),
    );
  }
}
