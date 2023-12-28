import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class Movie {
  Movie(
    this.id,
    this.adult,
    this.title,
    this.voteAverage,
    this.backdropPath,
    this.genres,
    this.imdbId,
    this.runtime,
  );

  final int id;
  final bool adult;
  final String title;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;
  final List<Genre> genres;
  @JsonKey(name: 'imdb_id')
  final String imdbId;
  final int runtime;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable()
class Genre {
  Genre(this.id, this.name);

  final int id;
  final String name;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
