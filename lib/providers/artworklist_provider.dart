import 'package:flutter/material.dart';

import '../models/artwork_item.dart';

class ArtworkList with ChangeNotifier {
  final List<ArtworkItem> _globalArtworkList = [
    ArtworkItem(
      itemId: 'artworkitem1',
      itemTitle: 'Nightfall',
      itemArtist: 'John Doe',
      itemDescription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      itemImagePath: 'assets/images/artwork_image1.jpg',
      itemCreationDate: '3rd Feb, 2022',
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
      itemPrice: 4200.0,
    ),
    ArtworkItem(
      itemId: 'artworkitem3',
      itemTitle: 'Red Sunset',
      itemArtist: 'Robert Green',
      itemDescription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      itemImagePath: 'assets/images/artwork_image3.jpg',
      itemCreationDate: '21st Jan, 2020',
      itemPrice: 3700.0,
    ),
    ArtworkItem(
      itemId: 'artworkitem4',
      itemTitle: 'Northern Lights',
      itemArtist: 'Jack Black',
      itemDescription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      itemImagePath: 'assets/images/artwork_image4.jpg',
      itemCreationDate: '5th Mar, 2018',
      itemPrice: 6500.0,
    ),
    ArtworkItem(
      itemId: 'artworkitem5',
      itemTitle: 'Snowy Peaks',
      itemArtist: 'John Doe',
      itemDescription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      itemImagePath: 'assets/images/artwork_image5.jpg',
      itemCreationDate: '12th Dec, 2016',
      itemPrice: 4999.0,
    ),
  ];

  final List<ArtworkItem> _globalFavoritesList = [];
  final List<ArtworkItem> _globalCart = [];
  double _globalCartTotal = 0.0;

  List<ArtworkItem> get globalArtworkList => _globalArtworkList;
  List<ArtworkItem> get globalFavoritesList => _globalFavoritesList;
  List<ArtworkItem> get globalCart => _globalCart;
  double get globalCartTotal => _globalCartTotal;

  bool checkFavorite(passedArtworkId) {
    List<ArtworkItem> foundList =
        globalFavoritesList.where((eachArtwork) => eachArtwork.itemId == passedArtworkId).toList();
    if (foundList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void addToFavoritesList(passedArtworkId) {
    List<ArtworkItem> foundList =
        globalArtworkList.where((eachArtwork) => eachArtwork.itemId == passedArtworkId).toList();
    ArtworkItem itemToFav = foundList.first;
    if (globalFavoritesList.any((item) => item == itemToFav)) {
      debugPrint('(Add Function) Already There');
    } else {
      globalFavoritesList.add(itemToFav);
    }
    notifyListeners();
  }

  void removeFromFavoritesList(passedArtworkId) {
    List<ArtworkItem> foundList =
        globalFavoritesList.where((eachArtwork) => eachArtwork.itemId == passedArtworkId).toList();
    ArtworkItem itemToUnFav = foundList.first;
    if (globalFavoritesList.any((item) => item == itemToUnFav)) {
      globalFavoritesList.remove(itemToUnFav);
    } else {
      debugPrint('(Remove Function) Not There');
    }
    notifyListeners();
  }

//---------------------------------------

  bool checkCart(passedArtworkId) {
    List<ArtworkItem> foundList = globalCart.where((eachArtwork) => eachArtwork.itemId == passedArtworkId).toList();
    if (foundList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void addToCart(passedArtworkId) {
    List<ArtworkItem> foundList =
        globalArtworkList.where((eachArtwork) => eachArtwork.itemId == passedArtworkId).toList();
    ArtworkItem itemToAdd = foundList.first;
    if (globalCart.any((item) => item == itemToAdd)) {
      debugPrint('(Add Function) Already There');
    } else {
      globalCart.add(itemToAdd);
      _globalCartTotal = updateCartTotal();
    }
    notifyListeners();
  }

  void removeFromCart(passedArtworkId) {
    List<ArtworkItem> foundList = globalCart.where((eachArtwork) => eachArtwork.itemId == passedArtworkId).toList();
    ArtworkItem itemToRemove = foundList.first;
    if (globalCart.any((item) => item == itemToRemove)) {
      globalCart.remove(itemToRemove);
      _globalCartTotal = updateCartTotal();
    } else {
      debugPrint('(Remove Function) Not There');
    }
    notifyListeners();
  }

  double updateCartTotal() {
    double localCartTotal = 0.0;
    // globalCart.map((eachArtworkItem) {
    //   localCartTotal += eachArtworkItem.itemPrice;
    //   debugPrint('Total: $localCartTotal');
    // });
    for (int i = 0; i < globalCart.length; i++) {
      localCartTotal = localCartTotal + globalCart[i].itemPrice;
    }
    return localCartTotal;
  }
}
