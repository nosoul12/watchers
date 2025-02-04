import 'package:flutter/material.dart';
import 'package:watchers/main.dart';
import 'package:watchers/src/screens/fav_screen.dart';
import 'package:watchers/src/screens/watchlist_screen.dart';

class Bottomtab extends StatelessWidget {
  const Bottomtab({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              MaterialPageRoute(builder: (context) => HomePage());
            },
            icon: Icon(Icons.home),
          ),
          label: 'Home'),
      BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                MaterialPageRoute(builder: (context) => Fav_Screen());
              },
              icon: Icon(Icons.favorite)),
          label: 'Favrouti'),
      BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              MaterialPageRoute(builder: (context) => WatchlistScreen());
            },
            icon: Icon(Icons.abc_outlined),
            color: Colors.white,
          ),
          label: 'Watchlist'),
    ]);
  }
}
