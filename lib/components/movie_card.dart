import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/models/movieless_model.dart';
import 'package:movieflix/screens/movie_details.dart';

class MovieCard extends StatelessWidget {
  final bool grid;
  final Movie? movie;
  final MovieLess? movieLess;

  const MovieCard({super.key, this.grid = false, this.movie, this.movieLess});

  double calculateRating(num rating) {
    return rating * 5 / 10;
  }

  String convertMinutesToHours(int minutes) {
    final int hours = minutes ~/ 60;
    final int remainingMinutes = minutes % 60;

    return '$hours h $remainingMinutes min';
  }

  Widget createGenreWidget() {
    return Row(
      children: movie!.genres
          .map(
            (genre) => Container(
              margin: const EdgeInsets.only(right: 4),
              child: InkWell(
                onTap: () {},
                child: Badge(
                  backgroundColor: const Color.fromARGB(255, 219, 227, 255),
                  textColor: const Color.fromARGB(255, 136, 164, 232),
                  alignment: Alignment.center,
                  smallSize: 12,
                  largeSize: 20,
                  label: Text(
                    genre.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget gridView(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              movieId: movie!.id,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie!.backdropPath}',
                width: 85,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 85,
                    height: 120,
                    child: Center(
                      child: Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 200,
                    child: Text(
                      movie!.title,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 17, 14, 71),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
                        '${calculateRating(movie!.voteAverage).toStringAsFixed(2)}/5',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 156, 156, 156),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Scrollbar(
                        thumbVisibility: false,
                        trackVisibility: false,
                        thickness: 0,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: createGenreWidget(),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.black,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        convertMinutesToHours(movie!.runtime),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listView(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              movieId: movieLess!.id,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          width: 143,
          height: 283,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 194,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                    image: movieLess!.backdropPath != null
                        ? DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${movieLess!.backdropPath}'),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      movieLess!.title,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: Row(
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
                            '${calculateRating(movieLess!.voteAverage).toStringAsFixed(2)}/5',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 156, 156, 156),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return grid ? gridView(context) : listView(context);
  }
}
