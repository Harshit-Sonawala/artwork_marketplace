import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

class CustomPhotoView extends StatefulWidget {
  final String passedImagePath;

  const CustomPhotoView(this.passedImagePath, {Key? key}) : super(key: key);

  @override
  State<CustomPhotoView> createState() => _CustomPhotoViewState();
}

class _CustomPhotoViewState extends State<CustomPhotoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: PhotoView(
        imageProvider: AssetImage(widget.passedImagePath),
      ),
    );
  }
}
