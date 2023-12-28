// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      json['id'] as int,
      json['adult'] as bool,
      json['title'] as String,
      (json['vote_average'] as num).toDouble(),
      json['backdrop_path'] as String,
      (json['genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['imdb_id'] as String,
      json['runtime'] as int,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'title': instance.title,
      'vote_average': instance.voteAverage,
      'backdrop_path': instance.backdropPath,
      'genres': instance.genres,
      'imdb_id': instance.imdbId,
      'runtime': instance.runtime,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      json['id'] as int,
      json['name'] as String,
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
