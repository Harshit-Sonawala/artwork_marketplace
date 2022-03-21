import 'package:flutter/material.dart';
import '../models/artwork_item.dart';

import '../reusableWidgets/custom_photo_view.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<ArtworkItem> finalArtworkList = [
    ArtworkItem(
      itemId: 'artworkitem1',
      itemTitle: 'Artwork One',
      itemArtist: 'John Doe',
      itemDescription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      itemImagePath: 'assets/images/artwork_image1.jpg',
      itemCreationDate: '3rd February 2022',
      itemPrice: 2000.0,
    ),
    ArtworkItem(
      itemId: 'artworkitem2',
      itemTitle: 'Dusk',
      itemArtist: 'Jane Doe',
      itemDescription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      itemImagePath: 'assets/images/artwork_image2.jpg',
      itemCreationDate: '15th September 2020',
      itemPrice: 3500.0,
    ),
    ArtworkItem(
      itemId: 'artworkitem3',
      itemTitle: 'Red Sunset',
      itemArtist: 'Robert Green',
      itemDescription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      itemImagePath: 'assets/images/artwork_image3.jpg',
      itemCreationDate: '21st January 2020',
      itemPrice: 4000.0,
    ),
    ArtworkItem(
      itemId: 'artworkitem4',
      itemTitle: 'Northern Lights',
      itemArtist: 'Jack Black',
      itemDescription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      itemImagePath: 'assets/images/artwork_image4.jpg',
      itemCreationDate: '5th March 2018',
      itemPrice: 10500.0,
    ),
    ArtworkItem(
      itemId: 'artworkitem5',
      itemTitle: 'Snowy Peaks',
      itemArtist: 'John Doe',
      itemDescription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      itemImagePath: 'assets/images/artwork_image5.jpg',
      itemCreationDate: '12th February 2016',
      itemPrice: 12999.0,
    ),
  ];
  // List<bool> _isExpandedList = List<bool>.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
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
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: Image.asset(
                      // 'assets/images/placeholder.jpg',
                      finalArtworkList[listViewBuilderIndex].itemImagePath,
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
                              builder: (context) =>
                                  CustomPhotoView(finalArtworkList[listViewBuilderIndex].itemImagePath),
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
                          onTap: () => {debugPrint('Toggled Favorite')},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
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
                    // setState(() => _isExpandedList[listViewBuilderIndex] = !_isExpandedList[listViewBuilderIndex]),
                    setState(() => finalArtworkList[listViewBuilderIndex].isExpanded =
                        !finalArtworkList[listViewBuilderIndex].isExpanded),
                children: [
                  ExpansionPanel(
                    canTapOnHeader: true,
                    isExpanded: finalArtworkList[listViewBuilderIndex].isExpanded,
                    headerBuilder: (context, isExpanded) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        finalArtworkList[listViewBuilderIndex].itemTitle,
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
                            Text(finalArtworkList[listViewBuilderIndex].itemArtist, style: TextStyle(fontSize: 16)),
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
                              finalArtworkList[listViewBuilderIndex].itemCreationDate.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                          child: Text(
                            finalArtworkList[listViewBuilderIndex].itemDescription,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                        'Price: Rs. 2999',
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
