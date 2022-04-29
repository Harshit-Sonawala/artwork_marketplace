import 'package:artwork_marketplace/providers/artworklist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './reusableWidgets/create_material_color.dart';
import './screens/home_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ArtworkList>(create: (context) => ArtworkList()),
        ],
        child: const ArtworkMarketplace(),
      ),
      // const ArtworkMarketplace(),
    );

class ArtworkMarketplace extends StatefulWidget {
  const ArtworkMarketplace({Key? key}) : super(key: key);

  @override
  State<ArtworkMarketplace> createState() => _ArtworkMarketplaceState();
}

class _ArtworkMarketplaceState extends State<ArtworkMarketplace> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artwork Marketplace',
      theme: ThemeData(
        primarySwatch: createMaterialColor(
          // const Color(0xff378BEC),
          const Color(0xff0099e0),
        ),
        fontFamily: 'Montserrat',
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
