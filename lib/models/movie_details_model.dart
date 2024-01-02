import 'package:json_annotation/json_annotation.dart';
import 'package:movieflix/models/movie_model.dart';

part 'movie_details_model.g.dart';

@JsonSerializable()
class MovieModel {
  MovieModel(
    this.adult,
    this.budget,
    this.genres,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.title,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.runtime,
    this.voteAverage,
    this.cast,
    this.videos,
  );

  final bool adult;
  final int budget;
  final List<Genre> genres;
  final int id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  final String title;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final int runtime;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  final List<Cast>? cast;
  final List<Video>? videos;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}

@JsonSerializable()
class Cast {
  Cast(this.id, this.name, this.profilePath);

  final int id;
  final String name;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable()
class Video {
  Video(this.key, this.name, this.site, this.type);

  final String key;
  final String name;
  final String site;
  final String type;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
