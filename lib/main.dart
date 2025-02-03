import 'package:flutter/material.dart';
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
      bottomNavigationBar: BottomNavigationBar(items: const [
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
      ]),
      appBar: AppBar(
        title: Column(
          children: [
            Text('Watcher'),
            Text(
              'Movies',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ))
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100, // Added height constraint to SingleChildScrollView
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.blue,
                    child: const Center(
                        child: Text('Movie',
                            style: TextStyle(color: Colors.white))),
                  );
                }),
              ),
            ),
          ),
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
