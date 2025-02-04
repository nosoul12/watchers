import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchers/src/providers/watchlist_provider.dart';
import 'package:watchers/src/screens/movie_detail_screen.dart';
import 'package:watchers/src/screens/search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredMovies = [];

  // Dummy movie data (Replace with API data later)
  final List<Map<String, String>> _movies = [
    {
      'title': 'Inception',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg',
    },
    {
      'title': 'Interstellar',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg',
    },
    {
      'title': 'The Dark Knight',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movies;
  }

  void _searchMovies(String query) {
    setState(() {
      _filteredMovies = _movies
          .where((movie) =>
              movie['title']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watcher'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: _searchMovies,
              decoration: InputDecoration(
                hintText: "Search movies...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: _filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = _filteredMovies[index];
                final isWatchlisted =
                    watchlistProvider.isInWatchlist(movie['title']!);
                final isFavorited =
                    watchlistProvider.isInFavorites(movie['title']!);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          title: movie['title']!,
                          imageUrl: movie['imageUrl']!,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.network(
                            movie['imageUrl']!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['title']!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isFavorited
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorited
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      if (isFavorited) {
                                        watchlistProvider.removeFromFavorites(
                                            movie['title']!);
                                      } else {
                                        watchlistProvider.addToFavorites(
                                            movie['title']!,
                                            movie['imageUrl']!);
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isWatchlisted ? Icons.check : Icons.add,
                                      color: isWatchlisted
                                          ? Colors.green
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      if (isWatchlisted) {
                                        watchlistProvider.removeFromWatchlist(
                                            movie['title']!);
                                      } else {
                                        watchlistProvider.addToWatchlist(
                                            movie['title']!,
                                            movie['imageUrl']!);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Search Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Search_Screen(),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
