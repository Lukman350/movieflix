import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/models/movieless_model.dart';

class Api {
  static const String apiUrl = 'https://movieflix-api-seven.vercel.app/api';

  static Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$apiUrl/get_popular'));

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final List<Movie> movies = [];

      for (var movie in jsonResponse) {
        movies.add(Movie.fromJson(movie));
      }

      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<List<MovieLess>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse('$apiUrl/get_now_playing'));

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final List<MovieLess> movies = [];

      for (var movie in jsonResponse) {
        movies.add(MovieLess.fromJson(movie));
      }

      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
