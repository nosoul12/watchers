
import 'package:flutter/material.dart';
import 'package:watchers/src/services/movie_serviece.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  final String email;
  final String userId;

  ProfileScreen({required this.username, required this.email, required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<dynamic> watchlist = [];
  List<dynamic> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // _fetchUserMovies();
  }

  // Future<void> _fetchUserMovies() async {
  //   try {
  //     final watchlistResponse = await MovieService.addToWatchlist(widget.userId);
  //     final favoritesResponse = await MovieService.addToFavorites(widget.userId);
  //     setState(() {
  //       watchlist = watchlistResponse;
  //       favorites = favoritesResponse;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Error loading data: $e")));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Username: ${widget.username}", style: TextStyle(fontSize: 18)),
                  Text("Email: ${widget.email}", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  Text("Watchlist", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ...watchlist.map((movie) => ListTile(title: Text(movie['title']))).toList(),
                  SizedBox(height: 20),
                  Text("Favorites", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ...favorites.map((movie) => ListTile(title: Text(movie['title']))).toList(),
                ],
              ),
            ),
    );
  }
}
