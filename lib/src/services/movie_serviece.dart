import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watchers/src/models/movie.dart';

class MovieService {
  static const String baseUrl = "https://backend-vpms.onrender.com";

  static Future<List<Movie>> fetchMovies() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/tmdb/trending')); // Removed /tmdb

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);
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

  static Future<List<Movie>> searchMovies(String query) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/tmdb/search?query=$query'));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);

        // Check if the response itself is a list instead of a map
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

  /// Searches movies by query
  // static Future<List<Movie>>  async {
  //   try {
  //     final response =

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> decodedData = json.decode(response.body);

  //       if (decodedData.containsKey('results') &&
  //           decodedData['results'] is List) {
  //         final List<dynamic> moviesJson = decodedData['results'];
  //         return moviesJson.map((json) => Movie.fromJson(json)).toList();
  //       } else {
  //         throw Exception('Invalid API response: Missing "results" key.');
  //       }
  //     } else {
  //       throw Exception(
  //           'Failed to load search results. Status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print("Error searching movies: $e");
  //     return [];
  //   }
  // }

  /// Fetches movie details by movie ID
  static Future<Movie?> fetchMovieDetails(int movieId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/tmdb/movie/$movieId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Movie.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to load movie details. Status: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching movie details: $e");
      return null;
    }
  }
}
