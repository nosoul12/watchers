import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchers/src/models/movie.dart';
import 'package:watchers/src/providers/watchlist_provider.dart';
import 'package:watchers/src/services/movie_serviece.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  final String title;
  final String imageUrl;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
    required this.title,
    required this.imageUrl,
  });

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Movie? movieDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovieDetails();
  }

  Future<void> _fetchMovieDetails() async {
    try {
      final details = await MovieService.fetchMovieDetails(widget.movieId);
      setState(() {
        movieDetails = details;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    final isWatchlisted = watchlistProvider.isInWatchlist(widget.movieId);
    final isFavorited = watchlistProvider.isInFavorites(widget.movieId);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : Colors.white,
            ),
            onPressed: () {
              if (isWatchlisted) {
                watchlistProvider.removeFromWatchlist(widget.movieId);
              } else {
                watchlistProvider.addToWatchlist(
                    widget.movieId, widget.title, widget.imageUrl);
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.imageUrl,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (isWatchlisted) {
                          watchlistProvider.removeFromWatchlist(widget.movieId);
                        } else {
                          watchlistProvider.addToWatchlist(
                              widget.movieId, widget.title, widget.imageUrl);
                        }
                      },
                      child: Text(isWatchlisted
                          ? 'Remove from Watchlist'
                          : 'Add to Watchlist'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Overview",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      movieDetails?.overview ?? "No description available.",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow(
                      "Original Title:", movieDetails?.originalTitle),
                  _buildDetailRow("Release Date:", movieDetails?.releaseDate),
                  _buildDetailRow(
                      "Rating:", movieDetails?.voteAverage.toString()),
                  _buildDetailRow("Language:", movieDetails?.originalLanguage),
                  _buildDetailRow(
                      "Popularity:", movieDetails?.popularity.toString()),
                  _buildDetailRow(
                      "Vote Count:", movieDetails?.voteCount.toString()),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value ?? "N/A",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
