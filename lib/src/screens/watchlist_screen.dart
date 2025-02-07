import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchers/src/providers/watchlist_provider.dart';
import 'package:watchers/src/screens/movie_detail_screen.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    final watchlist = watchlistProvider.watchlist;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Watchlist')),
      body: watchlist.isEmpty
          ? const Center(child: Text('No movies in your watchlist yet!'))
          : ListView.builder(
              itemCount: watchlist.length,
              itemBuilder: (context, index) {
                final movie = watchlist[index];
                return ListTile(
                  leading: Image.network(movie['imageUrl']!,
                      width: 50, height: 75, fit: BoxFit.cover),
                  title: Text(movie['title']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      watchlistProvider.removeFromWatchlist(movie['title']!);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                                movieId: movie['id'], // Add this
                                title: movie['title'],
                                imageUrl: movie['imageUrl'],
                              )),
                    );
                  },
                );
              },
            ),
    );
  }
}
