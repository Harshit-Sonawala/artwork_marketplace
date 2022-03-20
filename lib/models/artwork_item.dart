import 'dart:ffi';

class ArtworkItem {
  String itemId;
  String itemTitle;
  String itemArtist;
  String itemDescription;
  String itemImagePath;
  DateTime itemCreationDate;
  double itemPrice;
  bool isExpanded;

  ArtworkItem({
    required this.itemId,
    required this.itemTitle,
    required this.itemArtist,
    required this.itemDescription,
    required this.itemImagePath,
    required this.itemCreationDate,
    required this.itemPrice,
    this.isExpanded = false,
  });
}
