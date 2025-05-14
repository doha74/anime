import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie.dart';

class ApiService {
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = 'a3c51275a66b25700a4f172827ffcaa7'; 

  Future<List<Movie>> fetchMovies() async {
    final url = Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
