import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_details_model.dart';
import 'dart:convert' as convert;

import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/models/movieless_model.dart';

class Api {
  static const String apiUrl = 'https://movieflix-api-seven.vercel.app/api';
  // static const String apiUrl = 'http://localhost:3000/api';

  static Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final response = await http.get(Uri.parse('$apiUrl/popular/?page=$page'));

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

  static Future getNowPlayingMovies({int page = 1, bool full = false}) async {
    final response = await http.get(
        Uri.parse('$apiUrl/now_playing?page=$page${full ? '&full=true' : ''}'));

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final List<MovieLess> movies = [];
      final List<Movie> fullMovies = [];

      for (var movie in jsonResponse) {
        if (!full) {
          movies.add(MovieLess.fromJson(movie));
        } else {
          fullMovies.add(Movie.fromJson(movie));
        }
      }

      return full == true ? fullMovies : movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future getMovieDetails(int movieId, {bool lessData = false}) async {
    final response = await http.get(Uri.parse('$apiUrl/movie/$movieId'));

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);

      return lessData == true
          ? Movie.fromJson(jsonResponse)
          : MovieModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load movie');
    }
  }

  static Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final response =
        await http.get(Uri.parse('$apiUrl/search/?query=$query&page=$page'));

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final List<Movie> movies = [];

      for (var movie in jsonResponse) {
        movies.add(Movie.fromJson(movie));
      }

      return movies;
    } else {
      throw Exception('Failed to load movie');
    }
  }
}
