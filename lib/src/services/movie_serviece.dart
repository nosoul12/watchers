import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watchers/src/models/movie.dart';

class MovieService {
  static Future<Movie> fetchMovieDetails(int movieId) async {
    final response = await http.get(
        Uri.parse('https://backendof-watchers.onrender.com/movie/$movieId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = json.decode(response.body);
      return Movie.fromJson(decodedData);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  static Future<List<Movie>> fetchMovies() async {
    final response = await http
        .get(Uri.parse('https://backendof-watchers.onrender.com/trending'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      if (decodedData is List) {
        return decodedData.map((json) => Movie.fromJson(json)).toList();
      } else if (decodedData.containsKey('results') &&
          decodedData['results'] is List) {
        final List<dynamic> moviesJson = decodedData['results'];
        return moviesJson.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception(
            'Invalid API response: JSON is not a list and "results" field is missing or not a list');
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
