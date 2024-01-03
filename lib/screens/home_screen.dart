import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movieflix/components/button.dart';
import 'package:movieflix/components/error_modal.dart';
import 'package:movieflix/components/movie_card.dart';
import 'package:movieflix/components/skeletons/movie_card.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/api/movies.dart';
import 'package:movieflix/models/movieless_model.dart';
import 'package:movieflix/screens/see_more_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Future getNowPlayingMovies() async {
    return await Api.getNowPlayingMovies();
  }

  static Future<List<Movie>> getPopularMovies() async {
    return await Api.getPopularMovies();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late Future _nowPlayingMovies;
  late Future<List<Movie>> _popularMovies;
  final ValueNotifier<bool> _errorNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _nowPlayingMovies = HomeScreen.getNowPlayingMovies();
    _popularMovies = HomeScreen.getPopularMovies();

    _errorNotifier.addListener(() {
      if (_errorNotifier.value) {
        ErrorModal(
          context: context,
          retry: () {
            setState(() {
              _nowPlayingMovies = HomeScreen.getNowPlayingMovies();
              _popularMovies = HomeScreen.getPopularMovies();
              _errorNotifier.value = false;
            });

            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500));

        try {
          _nowPlayingMovies = HomeScreen.getNowPlayingMovies();
          _popularMovies = HomeScreen.getPopularMovies();

          debugPrint("Now Playing Movies $_nowPlayingMovies");
          debugPrint("Popular Movies $_popularMovies");
        } catch (error) {
          setState(() {
            _errorNotifier.value = true;
          });

          debugPrint("nowplaying: $_nowPlayingMovies");
          debugPrint("popular: $_popularMovies");
        }
      },
      backgroundColor: Colors.white,
      color: const Color.fromARGB(255, 17, 14, 71),
      strokeWidth: 3.0,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      child: Padding(
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SeeMoreScreen(
                                  type: MovieType.nowPlaying,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: _nowPlayingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(4.0),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) {
                              final MovieLess movieLess = snapshot.data![index];

                              return MovieCard(
                                movieLess: movieLess,
                                grid: false,
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            _errorNotifier.value = true;
                          });

                          return const MovieCardSkeleton(
                              type: SkeletonType.horizontal);
                        }
                        return const MovieCardSkeleton(
                            type: SkeletonType.horizontal);
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SeeMoreScreen(
                                  type: MovieType.popular,
                                ),
                              ),
                            );
                          }),
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
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            _errorNotifier.value = true;
                          });

                          return const MovieCardSkeleton(
                              type: SkeletonType.vertical);
                        }
                        return const MovieCardSkeleton(
                            type: SkeletonType.vertical);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
