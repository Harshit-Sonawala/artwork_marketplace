import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/artworklist_provider.dart';
import '../reusableWidgets/custom_photo_view.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<bool> _isExpandedList = List<bool>.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    return context.watch<ArtworkList>().globalFavoritesList.isEmpty
        ? Center(
            child: Text(
              'Add Items to Favorites',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 18,
              ),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: context.watch<ArtworkList>().globalFavoritesList.length,
            itemBuilder: (BuildContext context, listViewBuilderIndex) {
              return Card(
                margin: const EdgeInsets.only(bottom: 25),
                elevation: 2.5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          child: Image.asset(
                            // 'assets/images/placeholder.jpg',
                            context.watch<ArtworkList>().globalFavoritesList[listViewBuilderIndex].itemImagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustomPhotoView(context
                                        .watch<ArtworkList>()
                                        .globalFavoritesList[listViewBuilderIndex]
                                        .itemImagePath),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(0, 0, 0, 0.4),
                                  ),
                                  child: const Icon(
                                    Icons.fullscreen,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () => {
                                  context.read<ArtworkList>().checkFavorite(
                                            context
                                                .read<ArtworkList>()
                                                .globalFavoritesList[listViewBuilderIndex]
                                                .itemId,
                                          )
                                      ? {
                                          context.read<ArtworkList>().removeFromFavoritesList(
                                                context
                                                    .read<ArtworkList>()
                                                    .globalFavoritesList[listViewBuilderIndex]
                                                    .itemId,
                                              ),
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Removed From Favorites'),
                                              duration: Duration(milliseconds: 500),
                                            ),
                                          ),
                                        }
                                      : {
                                          context.read<ArtworkList>().addToFavoritesList(
                                                context
                                                    .read<ArtworkList>()
                                                    .globalFavoritesList[listViewBuilderIndex]
                                                    .itemId,
                                              ),
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Added To Favorites'),
                                              duration: Duration(milliseconds: 500),
                                            ),
                                          ),
                                        }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(0, 0, 0, 0.4),
                                  ),
                                  child: const Icon(
                                    // context.watch<ArtworkList>().checkFavorite(
                                    //           context.read<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemId,
                                    //         )
                                    //     ? Icons.favorite
                                    //     : Icons.favorite_border,
                                    Icons.cancel,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ExpansionPanelList(
                      expandedHeaderPadding: const EdgeInsets.all(5),
                      elevation: 0,
                      animationDuration: const Duration(milliseconds: 400),
                      expansionCallback: (i, isExpanded) => setState(
                          () => _isExpandedList[listViewBuilderIndex] = !_isExpandedList[listViewBuilderIndex]),
                      // setState(() => context.watch<ArtworkList>().globalFavoritesList[listViewBuilderIndex].isExpanded =
                      //     !context.watch<ArtworkList>().globalFavoritesList[listViewBuilderIndex].isExpanded),
                      children: [
                        ExpansionPanel(
                          canTapOnHeader: true,
                          isExpanded: _isExpandedList[listViewBuilderIndex],
                          headerBuilder: (context, isExpanded) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              context.watch<ArtworkList>().globalFavoritesList[listViewBuilderIndex].itemTitle,
                              style: TextStyle(fontSize: 21, color: Theme.of(context).primaryColor),
                            ),
                          ),
                          body: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      context.watch<ArtworkList>().globalFavoritesList[listViewBuilderIndex].itemArtist,
                                      style: TextStyle(fontSize: 16)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircleAvatar(
                                        radius: 2.0,
                                        backgroundColor: Theme.of(context).primaryColor,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    context
                                        .watch<ArtworkList>()
                                        .globalArtworkList[listViewBuilderIndex]
                                        .itemCreationDate
                                        .toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                                child: Text(
                                  context
                                      .watch<ArtworkList>()
                                      .globalFavoritesList[listViewBuilderIndex]
                                      .itemDescription,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        // border: Border.all(width: 1.5, color: Colors.green),
                      ),
                      margin: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              // border: Border.all(width: 1.5, color: Colors.green),
                            ),
                            child: Text(
                              'Rs. ${context.watch<ArtworkList>().globalFavoritesList[listViewBuilderIndex].itemPrice.toString()}',
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () => debugPrint('Add to cart pressed'),
                          //   child: Ink(
                          //     decoration: const BoxDecoration(
                          //       borderRadius: BorderRadius.all(Radius.circular(10)),
                          //       color: Colors.blue,
                          //     ),
                          //     child: Container(
                          //       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          //       child: Row(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: const [
                          //           Icon(
                          //             Icons.add_shopping_cart,
                          //             color: Colors.white,
                          //           ),
                          //           SizedBox(width: 5),
                          //           Text('Add to cart', style: TextStyle(fontSize: 14, color: Colors.white)),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            onPressed: () => {
                              context.read<ArtworkList>().addToCart(
                                    context.read<ArtworkList>().globalFavoritesList[listViewBuilderIndex].itemId,
                                  ),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added To Cart'),
                                  duration: Duration(milliseconds: 500),
                                ),
                              ),
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.add_shopping_cart),
                                SizedBox(width: 5),
                                Text('Add to cart', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
  }
}
