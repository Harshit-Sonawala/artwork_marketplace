import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/artworklist_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return context.watch<ArtworkList>().globalCart.isEmpty
        ? Center(
            child: Text(
              'Add Items to Cart',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 18,
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: context.watch<ArtworkList>().globalCart.length,
                  itemBuilder: (BuildContext context, listViewBuilderIndex) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2.5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            child: Image.asset(
                              // 'assets/images/placeholder.jpg',
                              context.watch<ArtworkList>().globalCart[listViewBuilderIndex].itemImagePath,
                              fit: BoxFit.cover,
                              height: 120,
                              width: 100,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context.watch<ArtworkList>().globalCart[listViewBuilderIndex].itemTitle,
                                        style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        context.watch<ArtworkList>().globalCart[listViewBuilderIndex].itemArtist,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          // border: Border.all(width: 1.5, color: Colors.green),
                                        ),
                                        child: Text(
                                          'Rs. ${context.watch<ArtworkList>().globalCart[listViewBuilderIndex].itemPrice.toString()}',
                                          style: const TextStyle(fontSize: 16, color: Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FloatingActionButton(
                                        // style: ButtonStyle(
                                        //   shape: MaterialStateProperty.all(
                                        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        //   ),
                                        //   padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                                        //   backgroundColor: MaterialStateProperty.all(
                                        //     Colors.red,
                                        //   ),
                                        // ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        backgroundColor: Colors.red,
                                        elevation: 1.0,
                                        onPressed: () => context.read<ArtworkList>().removeFromCart(
                                              context.read<ArtworkList>().globalCart[listViewBuilderIndex].itemId,
                                            ),
                                        child: const Icon(Icons.remove_shopping_cart),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Card(
                margin: const EdgeInsets.only(left: 12.0, top: 0, right: 12.0, bottom: 12.0),
                elevation: 2.5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Total: Rs. ${context.read<ArtworkList>().globalCartTotal}',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
