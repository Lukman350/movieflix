import 'package:flutter/material.dart';
import 'package:movieflix/components/button.dart';
import 'package:movieflix/components/movie_card.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/api/movies.dart';
import 'package:movieflix/models/movieless_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Future<List<MovieLess>> getNowPlayingMovies() async {
    return await Api.getNowPlayingMovies();
  }

  static Future<List<Movie>> getPopularMovies() async {
    return await Api.getPopularMovies();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieLess>> _nowPlayingMovies;
  late Future<List<Movie>> _popularMovies;

  @override
  void initState() {
    super.initState();

    _nowPlayingMovies = HomeScreen.getNowPlayingMovies();
    _popularMovies = HomeScreen.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Now Playing',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 17, 14, 71),
                      ),
                    ),
                    Button(
                        variant: "secondary",
                        text: "See more",
                        onPressed: () {}),
                  ],
                ),
                Expanded(
                  child: FutureBuilder<List<MovieLess>>(
                    future: _nowPlayingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(4.0),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movieLess: snapshot.data![index],
                              grid: false,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Popular',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 17, 14, 71),
                        ),
                      ),
                    ),
                    Button(
                        variant: "secondary",
                        text: "See more",
                        onPressed: () {}),
                  ],
                ),
                Expanded(
                  child: FutureBuilder<List<Movie>>(
                    future: _popularMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
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
                        return Text("${snapshot.error}");
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
