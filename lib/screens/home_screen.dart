import 'package:flutter/material.dart';

import '../reusableWidgets/custom_drawer.dart';
import './feed_screen.dart';
import './favorites_screen.dart';
import './cart_screen.dart';
import './account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, Object>> _pageData = [
    {
      'page': FeedScreen(),
      'title': 'Browse for Artworks',
    },
    {
      'page': FavoritesScreen(),
      'title': 'Favorites',
    },
    {
      'page': CartScreen(),
      'title': 'Cart',
    },
    {
      'page': AccountScreen(),
      'title': 'Account',
    }
  ];

  int _selectedPageIndex = 0;

  // index is automatically passed to this function:
  void _selectPage(int tabItemSelected) {
    setState(() {
      _selectedPageIndex = tabItemSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageData[_selectedPageIndex]['title'].toString()),
        actions: _pageData[_selectedPageIndex]['actions'] != null
            ? _pageData[_selectedPageIndex]['actions'] as List<Widget>
            : null,
      ),
      drawer: const CustomDrawer(),
      body: _pageData[_selectedPageIndex]['page'] as Widget,
      floatingActionButton: FloatingActionButton(onPressed: () => {}, child: const Icon(Icons.add)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xffafd0f7),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
