import 'package:flutter/material.dart';

class Bottomtab extends StatelessWidget {
  const Bottomtab({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          label: 'Favrouti'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.toc,
            color: Colors.white,
          ),
          label: 'watchlist'),
    ]);
  }
}
