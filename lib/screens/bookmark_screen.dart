import 'package:flutter/material.dart';
import 'package:movieflix/components/movie_card.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movieflix/api/movies.dart';

class BookmarkScreen extends StatelessWidget {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  BookmarkScreen({super.key});

  Future<List<String>> _getBookmarks() async {
    final SharedPreferences prefs = await _preferences;
    final List<String> bookmarks =
        prefs.getStringList('bookmarks') ?? <String>[];

    return bookmarks;
  }

  Future<List<Movie>> _getBookmarkedMovies() async {
    final List<String> bookmarks = await _getBookmarks();
    final List<Movie> movies = <Movie>[];

    for (final String bookmark in bookmarks) {
      final Movie movie =
          await Api.getMovieDetails(int.parse(bookmark), lessData: true);
      movies.add(movie);
    }

    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _getBookmarkedMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark,
                    size: 100,
                    color: Color.fromARGB(255, 17, 14, 71),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No Bookmarks yet!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 17, 14, 71),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(4.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return MovieCard(
                movie: snapshot.data![index],
                grid: true,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
