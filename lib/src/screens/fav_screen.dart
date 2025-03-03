import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchers/src/providers/watchlist_provider.dart';
import 'package:watchers/src/providers/user_provider.dart';
import 'package:watchers/src/screens/movie_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.userId;
    final favorites = watchlistProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite movies added yet!',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final movie = favorites[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          movieId: movie['id'],
                          title: movie['title'],
                          imageUrl: movie['imageUrl'],
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
                            movie['imageUrl'],
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
                                movie['title'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      watchlistProvider
                                          .removeFromFavorites(movie['id']);
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
    );
  }
}


// class MovieService {
//   static const String baseUrl = 'https://api.example.com';

//   static Future<List<dynamic>> getWatchlist(String userId) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/watchlist?userId=$userId'),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       return json.decode(response.body)['watchlist'];
//     } else {
//       throw Exception('Failed to load watchlist');
//     }
//   }

//   static Future<List<dynamic>> getFavorites(String userId) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/favorites?userId=$userId'),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       return json.decode(response.body)['favorites'];
//     } else {
//       throw Exception('Failed to load favorites');
//     }
//   }
// }
