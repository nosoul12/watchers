// fix app bar
// create neended screen and fuctions
//attach it with backend
//fix ui
// check working
//posttttt

import 'package:flutter/material.dart';
import 'package:watchers/src/widgets/bottom_nav_bar.dart';
import 'package:watchers/src/widgets/custom_app_bar.dart';
import 'package:watchers/src/widgets/movie_card.dart';

void main() {
  runApp(const WatcherApp());
}

class WatcherApp extends StatelessWidget {
  const WatcherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Watcher',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottomtab(),
      appBar: AppBar(title: Appt()),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2 / 3, // Adjust the aspect ratio as needed
              ),
              itemCount: 10, // Dummy data count
              itemBuilder: (context, index) {
                return MovieCard(
                  title: 'Movie $index',
                  imageUrl:
                      'https://via.placeholder.com/200x300', // Dummy data image
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
