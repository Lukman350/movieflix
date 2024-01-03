import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movieflix/api/movies.dart';
import 'package:movieflix/components/bookmark_widget.dart';
import 'package:movieflix/components/error_modal.dart';
import 'package:movieflix/components/genre_widget.dart';
import 'package:movieflix/components/skeletons/movie_details.dart';
import 'package:movieflix/models/movie_details_model.dart';
import 'package:movieflix/screens/trailer_player.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;

  const MovieDetails({super.key, required this.movieId});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Future _movieData;
  final ValueNotifier<bool> _errorNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _movieData = Api.getMovieDetails(widget.movieId);

    _errorNotifier.addListener(() {
      if (_errorNotifier.value) {
        ErrorModal(
          context: context,
          retry: () {
            setState(() {
              _movieData = Api.getMovieDetails(widget.movieId);
              _errorNotifier.value = false;
            });

            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  String convertMinutesToHours(int minutes) {
    final int hours = minutes ~/ 60;
    final int remainingMinutes = minutes % 60;

    return '$hours h $remainingMinutes min';
  }

  double calculateRating(num rating) {
    return rating * 5 / 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _movieData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final MovieModel movie = snapshot.data!;

            final DateTime? releaseDate = movie.releaseDate != ''
                ? DateTime.tryParse(movie.releaseDate) ??
                    DateTime.parse('1970-01-01 00:00:00Z')
                : null;

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: movie.posterPath != null
                        ? BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.topCenter,
                              repeat: ImageRepeat.noRepeat,
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/original${movie.posterPath}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromARGB(255, 17, 14, 71)
                                    .withOpacity(0.8),
                                const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.9),
                              ],
                            ),
                          ),
                    child: Center(
                      child: movie.videos!.isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PlayTrailer(),
                                        settings: RouteSettings(
                                          arguments: movie.videos!
                                                  .where(
                                                    (element) =>
                                                        element.type ==
                                                        'Trailer',
                                                  )
                                                  .firstOrNull ??
                                              movie.videos!
                                                  .where((element) =>
                                                      element.site == 'YouTube')
                                                  .first,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Color.fromARGB(255, 17, 14, 71),
                                    size: 28,
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    fixedSize:
                                        MaterialStateProperty.all(const Size(
                                      45,
                                      45,
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  "Play Trailer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, 1),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : movie.posterPath == null
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline_rounded,
                                      size: 50,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'No Poster Available',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: const ButtonStyle(
                                splashFactory: NoSplash.splashFactory,
                              ),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 250,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 250,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.1),
                            offset: const Offset(0, -10),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: Scrollable(
                        physics: const BouncingScrollPhysics(),
                        viewportBuilder: (context, position) =>
                            SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      movie.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  BookmarkButton(movieId: movie.id),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 195, 25),
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${calculateRating(movie.voteAverage).toStringAsFixed(2)}/5',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 156, 156, 156),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Scrollbar(
                                thumbVisibility: false,
                                trackVisibility: false,
                                thickness: 0,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: GenreWidget(genres: movie.genres),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Length',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 156, 156, 156),
                                        ),
                                      ),
                                      Text(
                                        convertMinutesToHours(movie.runtime),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Language',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 156, 156, 156),
                                        ),
                                      ),
                                      Text(
                                        movie.originalLanguage.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Release Date',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 156, 156, 156),
                                        ),
                                      ),
                                      Text(
                                        // format release date to dd MMM yyyy
                                        releaseDate != null
                                            ? '${releaseDate.day.toString().padLeft(2, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.year.toString()}'
                                            : 'N/A',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 17, 14, 71),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    movie.overview,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 156, 156, 156),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cast',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 17, 14, 71),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: movie.cast!.length,
                                      itemBuilder: (context, index) {
                                        Cast cast = movie.cast![index];

                                        return Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              cast.profilePath != null
                                                  ? Container(
                                                      height: 72,
                                                      width: 72,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            'https://image.tmdb.org/t/p/original${cast.profilePath}',
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 72,
                                                      width: 72,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "No Photo Available",
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Center(
                                                child: Text(
                                                  cast.name
                                                      .replaceAll(' ', '\n'),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              _errorNotifier.value = true;
            });

            return const MovieDetailsSkeleton();
          }

          return const MovieDetailsSkeleton();
        },
      ),
    );
  }
}
