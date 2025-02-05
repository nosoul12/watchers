import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchers/src/providers/watchlist_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;

  const MovieDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    final isWatchlisted = watchlistProvider.isInWatchlist(title);
    final isFavorited = watchlistProvider.isInFavorites(title);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : Colors.white,
            ),
            onPressed: () {
              if (isFavorited) {
                watchlistProvider.removeFromFavorites(title);
              } else {
                watchlistProvider.addToFavorites(title, imageUrl);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Movie Title
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Watchlist Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (isWatchlisted) {
                    watchlistProvider.removeFromWatchlist(title);
                  } else {
                    watchlistProvider.addToWatchlist(title, imageUrl);
                  }
                },
                child: Text(
                  isWatchlisted ? 'Remove from Watchlist' : 'Add to Watchlist',
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Description Section
            const Text(
              "Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Movie description will be shown here from API.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),

            // Cast Section
            const Text(
              "Cast",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "Cast details will be shown here from API.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
