import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';

class GenreWidget extends StatelessWidget {
  final List<Genre> genres;

  const GenreWidget({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: genres
          .map(
            (genre) => Container(
              margin: const EdgeInsets.only(right: 4),
              child: InkWell(
                overlayColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 219, 227, 255),
                ),
                mouseCursor: SystemMouseCursors.click,
                splashFactory: InkRipple.splashFactory,
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
}
