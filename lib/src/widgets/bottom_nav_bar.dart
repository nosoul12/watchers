import 'package:flutter/material.dart';
import 'package:watchers/src/screens/fav_screen.dart';
import 'package:watchers/src/screens/home_screen.dart';
import 'package:watchers/src/screens/watchlist_screen.dart';

class BottomTb extends StatefulWidget {
  const BottomTb({super.key});

  @override
  State<BottomTb> createState() => _BottomTbState();
}

class _BottomTbState extends State<BottomTb> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const FavScreen(),
    const WatchlistScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Watchlist'),
        ],
      ),
    );
  }
}
