import 'package:flutter/material.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<Search_Screen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredMovies = [];

  final List<Map<String, String>> _movies = [
    {
      'title': 'Inception',
      'imageUrl': 'https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg',
    },
    {
      'title': 'Interstellar',
      'imageUrl': 'https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg',
    },
    {
      'title': 'The Dark Knight',
      'imageUrl': 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    },
  ];

  void _searchMovies(String query) {
    setState(() {
      _filteredMovies = _movies
          .where((movie) =>
              movie['title']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Movies")),
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
            child: ListView.builder(
              itemCount: _filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = _filteredMovies[index];
                return ListTile(
                  leading: Image.network(movie['imageUrl']!, width: 50),
                  title: Text(movie['title']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
