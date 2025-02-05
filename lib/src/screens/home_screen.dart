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
    {
      'title': 'The Matrix',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
    },
    {
      'title': 'Avengers: Endgame',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
    },
    {
      'title': 'Titanic',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/kHXEpyfl6zqn8a6YuozZUujufXf.jpg',
    },
    {
      'title': 'Joker',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
    },
    {
      'title': 'The Lion King',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/2bXbqYdUdNVa8VIWXVfclP2ICtT.jpg',
    },
    {
      'title': 'Shawshank Redemption',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
    },
    {
      'title': 'Forrest Gump',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
    },
    {
      'title': 'The Godfather',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
    },
    {
      'title': 'Pulp Fiction',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/tbajk8b9g2I1Z8dJqaECwAf5hhe.jpg',
    },
    {
      'title': 'Fight Club',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
    },
    {
      'title': 'The Avengers',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg',
    },
    {
      'title': 'Spider-Man: No Way Home',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/5weKUj6ybp81wAx7c2jEQuvhUO5.jpg',
    },
    {
      'title': 'Doctor Strange',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/gz5bgMlYtuG6Uzok2t6alTPU3dU.jpg',
    },
    {
      'title': 'Black Panther',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg',
    },
    {
      'title': 'Guardians of the Galaxy',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/y31QB9kn3XSudA15tV7UWQ9XLuW.jpg',
    },
    {
      'title': 'Thor: Ragnarok',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg',
    },
    {
      'title': 'Deadpool',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/inVq3FRqcYIRl2la8iZikYYxFNR.jpg',
    },
    {
      'title': 'John Wick',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg',
    },
    {
      'title': 'The Batman',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg',
    },
    {
      'title': 'Dune',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
    },
    {
      'title': 'Top Gun: Maverick',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg',
    },
    {
      'title': 'The Irishman',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/mbm8k3GFhXS0ROd9AD1gqYbIFbM.jpg',
    },
    {
      'title': 'The Wolf of Wall Street',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/sOxr33wnRuKazR9ClHek73T8qnK.jpg',
    },
    {
      'title': 'Blade Runner 2049',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg',
    },
    {
      'title': 'Mad Max: Fury Road',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/8tZYtuWezp8JbcsvHYO0O46tFbo.jpg',
    },
    {
      'title': 'Gladiator',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/ty8TGRuvJLPUmAR1H1nRIsgwvim.jpg',
    },
    {
      'title': 'The Departed',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/iZlgD9K26zUfaUad9sVXKUXx79V.jpg',
    },
    {
      'title': 'Saving Private Ryan',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/miDoEMlYDJhOCvxlzI0wZqBs9Yt.jpg',
    },
    {
      'title': 'Schindler’s List',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg',
    },
    {
      'title': 'Goodfellas',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/7DiQxgI9DxxUu4rtrwzVJpSL1tR.jpg',
    },
    {
      'title': 'The Prestige',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/rdL2KpUisQn4jPp19tkdT8knmpu.jpg',
    },
    {
      'title': 'The Revenant',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/ji3EC4bqScw7l2eH9zFg3xLZc3b.jpg',
    },
    {
      'title': 'Parasite',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
    },
    {
      'title': 'La La Land',
      'imageUrl':
          'https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg',
    }
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
                crossAxisCount: 3,
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
