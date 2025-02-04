import 'package:flutter/material.dart';

class WatchlistProvider with ChangeNotifier {
  final List<Map<String, String>> _watchlist = [];
  final List<Map<String, String>> _favorites = [];

  List<Map<String, String>> get watchlist => _watchlist;
  List<Map<String, String>> get favorites => _favorites;

  void addToWatchlist(String title, String imageUrl) {
    _watchlist.add({'title': title, 'imageUrl': imageUrl});
    notifyListeners();
  }

  void removeFromWatchlist(String title) {
    _watchlist.removeWhere((movie) => movie['title'] == title);
    notifyListeners();
  }

  bool isInWatchlist(String title) {
    return _watchlist.any((movie) => movie['title'] == title);
  }

  void addToFavorites(String title, String imageUrl) {
    _favorites.add({'title': title, 'imageUrl': imageUrl});
    notifyListeners();
  }

  void removeFromFavorites(String title) {
    _favorites.removeWhere((movie) => movie['title'] == title);
    notifyListeners();
  }

  bool isInFavorites(String title) {
    return _favorites.any((movie) => movie['title'] == title);
  }
}
