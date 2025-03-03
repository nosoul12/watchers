import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watchers/src/models/movie.dart';

class MovieService {
  static const String baseUrl = "https://backend-vpms.onrender.com";

  // Fetch trending movies
  static Future<List<Movie>> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tmdb/trending'));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        if (decodedData.containsKey('results') &&
            decodedData['results'] is List) {
          return (decodedData['results'] as List)
              .map((json) => Movie.fromJson(json))
              .toList();
        } else {
          throw Exception('Invalid API response: Missing "results" key.');
        }
      } else {
        throw Exception(
            'Failed to load trending movies. Status: ${response.statusCode}');
      }
    } catch (e) {
      print("🔥 Error fetching movies: $e");
      return [];
    }
  }

  // Search movies
  static Future<List<Movie>> searchMovies(String query) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/tmdb/search?query=$query'));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        if (decodedData is List) {
          return decodedData.map((json) => Movie.fromJson(json)).toList();
        }
        if (decodedData is Map<String, dynamic> &&
            decodedData.containsKey('results') &&
            decodedData['results'] is List) {
          return (decodedData['results'] as List)
              .map((json) => Movie.fromJson(json))
              .toList();
        } else {
          throw Exception('Invalid API response format.');
        }
      } else {
        throw Exception(
            'Failed to load search results. Status: ${response.statusCode}');
      }
    } catch (e) {
      print("🔥 Error fetching movies: $e");
      return [];
    }
  }

  // Fetch movie details
  static Future<Movie?> fetchMovieDetails(int movieId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/tmdb/movie/$movieId'));
      if (response.statusCode == 200) {
        return Movie.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to load movie details. Status: ${response.statusCode}');
      }
    } catch (e) {
      print("🔥 Error fetching movie details: $e");
      return null;
    }
  }

// User signup
  static Future<http.Response> signUp(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/Register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  // User login
  static Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/Login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    return response;
  }

  // Add movie to watchlist
  static Future<http.Response> addToWatchlist(
      String userId, int movieId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/watchlist/add'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'movieId': movieId}),
    );
    return response;
  }

  // Remove movie from watchlist
  static Future<http.Response> removeFromWatchlist(
      String userId, int movieId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/watchlist/remove'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'movieId': movieId}),
    );
    return response;
  }

  // Add movie to favorites
  static Future<http.Response> addToFavorites(
      String userId, int movieId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/favorites/add'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'movieId': movieId}),
    );
    return response;
  }

  // Fetch user's watchlist
  static Future<List<dynamic>> getWatchlist(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/watchlist?userId=$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['watchlist'];
    } else {
      throw Exception('Failed to load watchlist');
    }
  }

  static Future<List<dynamic>> getFavorites(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/favorites?userId=$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['favorites'];
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  // Remove movie from favorites
  static Future<http.Response> removeFromFavorites(
      String userId, int movieId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/favorites/remove'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'movieId': movieId}),
    );
    return response;
  }
}
