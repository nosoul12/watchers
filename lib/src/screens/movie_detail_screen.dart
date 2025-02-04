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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (isWatchlisted) {
                  watchlistProvider.removeFromWatchlist(title);
                } else {
                  watchlistProvider.addToWatchlist(title, imageUrl);
                }
              },
              child: Text(isWatchlisted ? 'Remove from Watchlist' : 'Add to Watchlist'),
            ),
          ],
        ),
      ),
    );
  }
}
