import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/artworklist_provider.dart';
import '../reusableWidgets/custom_photo_view.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  // List<ArtworkItem> finalArtworkList = context.watch<ArtworkList>().globalArtworkList;
  // List<bool> _isExpandedList = List<bool>.generate(context.read<ArtworkList>().globalArtworkList.length, (index) => false);
  List<bool> _isExpandedList = List<bool>.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    // int count = context.read<ArtworkList>().globalArtworkList.length;
    // debugPrint('$count');
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: context.watch<ArtworkList>().globalArtworkList.length,
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
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(
                      // 'assets/images/placeholder.jpg',
                      context.watch<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemImagePath,
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
                              builder: (context) => CustomPhotoView(
                                context.watch<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemImagePath,
                              ),
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
                                      context.read<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemId,
                                    )
                                ? {
                                    context.read<ArtworkList>().removeFromFavoritesList(
                                          context.read<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemId,
                                        ),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Removed From Favorites'),
                                        duration: Duration(milliseconds: 500),
                                      ),
                                    )
                                  }
                                : {
                                    context.read<ArtworkList>().addToFavoritesList(
                                          context.read<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemId,
                                        ),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Added To Favorites'),
                                        duration: Duration(milliseconds: 500),
                                      ),
                                    )
                                  }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                            child: Icon(
                              context.watch<ArtworkList>().checkFavorite(
                                        context.read<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemId,
                                      )
                                  ? Icons.favorite
                                  : Icons.favorite_border,
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
                expansionCallback: (i, isExpanded) =>
                    setState(() => _isExpandedList[listViewBuilderIndex] = !_isExpandedList[listViewBuilderIndex]),
                // setState(() => context.watch<ArtworkList>().globalArtworkList[listViewBuilderIndex].isExpanded =
                //     !context.watch<ArtworkList>().globalArtworkList[listViewBuilderIndex].isExpanded),
                children: [
                  ExpansionPanel(
                    canTapOnHeader: true,
                    isExpanded: _isExpandedList[listViewBuilderIndex],
                    headerBuilder: (context, isExpanded) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        context.watch<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemTitle,
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
                            Text(context.watch<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemArtist,
                                style: const TextStyle(fontSize: 16)),
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
                            context.watch<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemDescription,
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
                        'Rs. ${context.watch<ArtworkList>().globalArtworkList[listViewBuilderIndex].itemPrice.toString()}',
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
                      onPressed: () => debugPrint('Add to cart pressed'),
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
