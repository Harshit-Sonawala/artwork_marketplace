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
    return context.watch<ArtworkList>().globalFavoritesList.isEmpty
        ? Center(
            child: Text(
              'Add Items to Cart',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 18,
              ),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: context.watch<ArtworkList>().globalFavoritesList.length,
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
                        context.watch<ArtworkList>().globalFavoritesList[listViewBuilderIndex].itemImagePath,
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
                                  context.watch<ArtworkList>().globalFavoritesList[listViewBuilderIndex].itemTitle,
                                  style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  context.watch<ArtworkList>().globalFavoritesList[listViewBuilderIndex].itemArtist,
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
                                    'Rs. ${context.watch<ArtworkList>().globalFavoritesList[listViewBuilderIndex].itemPrice.toString()}',
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
                                  onPressed: () => debugPrint('Remove from cart pressed'),
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
          );
  }
}
