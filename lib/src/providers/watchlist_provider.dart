import 'package:flutter/material.dart';

class WatchlistProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _watchlist = [];
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get watchlist => _watchlist;
  List<Map<String, dynamic>> get favorites => _favorites;

  void addToWatchlist(int id, String title, String imageUrl) {
    _watchlist.add({'id': id, 'title': title, 'imageUrl': imageUrl});
    notifyListeners();
  }

  void removeFromWatchlist(int id) {
    _watchlist.removeWhere((movie) => movie['id'] == id);
    notifyListeners();
  }

  bool isInWatchlist(int id) {
    return _watchlist.any((movie) => movie['id'] == id);
  }

  void addToFavorites(int id, String title, String imageUrl) {
    _favorites.add({'id': id, 'title': title, 'imageUrl': imageUrl});
    notifyListeners();
  }

  void removeFromFavorites(int id) {
    _favorites.removeWhere((movie) => movie['id'] == id);
    notifyListeners();
  }

  bool isInFavorites(int id) {
    return _favorites.any((movie) => movie['id'] == id);
  }
}
