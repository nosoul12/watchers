import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watchers/src/models/movie.dart';
import 'package:watchers/src/providers/watchlist_provider.dart';
import 'package:watchers/src/screens/movie_detail_screen.dart';
import 'package:watchers/src/services/movie_serviece.dart';

import 'package:watchers/src/widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  /// Loads trending movies
  Future<void> loadMovies() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      List<Movie> fetchedMovies = await MovieService.fetchMovies();
      setState(() {
        _movies = fetchedMovies;
        _filteredMovies = fetchedMovies;
      });
    } catch (e) {
      print("Error fetching movies: $e");
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Searches movies based on user input
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        _filteredMovies = _movies;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      List<Movie> searchedMovies = await MovieService.searchMovies(query);
      setState(() {
        _filteredMovies = searchedMovies;
      });
    } catch (e) {
      print("Error searching movies: $e");
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);

    return Scaffold(
      appBar: Appt(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: searchMovies,
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
            child: _isLoading
                ? _buildLoadingGrid()
                : _isError
                    ? _buildErrorWidget()
                    : _filteredMovies.isEmpty
                        ? _buildNoResultsWidget()
                        : _buildMovieGrid(),
          ),
        ],
      ),
    );
  }

  /// Loading shimmer effect
  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 150,
          width: 100,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Error handling UI
  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red, size: 50),
          SizedBox(height: 10),
          Text("Failed to load movies. Please try again."),
          ElevatedButton(
            onPressed: loadMovies,
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }

  /// No results UI
  Widget _buildNoResultsWidget() {
    return Center(
      child: Text(
        "No movies found!",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Movie Grid UI
  Widget _buildMovieGrid() {
    return GridView.builder(
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

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailScreen(
                  movieId: movie.id,
                  title: movie.title,
                  imageUrl: movie.posterPath != null
                      ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                      : 'https://via.placeholder.com/150',
                ),
              ),
            );
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    movie.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                        : 'https://via.placeholder.com/150',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
