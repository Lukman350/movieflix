import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movieflix/components/error_modal.dart';
import 'package:movieflix/components/movie_card.dart';
import 'package:movieflix/components/skeletons/movie_card.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movieflix/api/movies.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();
  late Future<List<Movie>> _bookmarkedMovies;
  final ValueNotifier<bool> _errorNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _bookmarkedMovies = _getBookmarkedMovies();
    _errorNotifier.addListener(() {
      if (_errorNotifier.value) {
        ErrorModal(
          context: context,
          retry: () {
            setState(() {
              _bookmarkedMovies = _getBookmarkedMovies();
            });
          },
        );
      }
    });
  }

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
      future: _bookmarkedMovies,
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
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _errorNotifier.value = true;
          });

          return const MovieCardSkeleton(type: SkeletonType.vertical);
        }

        return const MovieCardSkeleton(type: SkeletonType.vertical);
      },
    );
  }
}
