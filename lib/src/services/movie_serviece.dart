import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  static const String _apiKey = 'YOUR_TMDB_API_KEY';
  static const String _baseUrl = 'https://api.themoviedb.org/3/movie';

  static Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final url = '$_baseUrl/$movieId?api_key=$_apiKey&language=en-US';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Error fetching movie details: $e');
    }
  }
}
