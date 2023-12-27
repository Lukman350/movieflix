// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      json['adult'] as bool,
      json['budget'] as int,
      (json['genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['id'] as int,
      json['imdb_id'] as String?,
      json['original_language'] as String,
      json['title'] as String,
      json['overview'] as String,
      json['poster_path'] as String,
      json['runtime'] as int,
      (json['vote_average'] as num).toDouble(),
      (json['cast'] as List<dynamic>)
          .map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'budget': instance.budget,
      'genres': instance.genres,
      'id': instance.id,
      'imdb_id': instance.imdbId,
      'original_language': instance.originalLanguage,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'runtime': instance.runtime,
      'vote_average': instance.voteAverage,
      'cast': instance.cast,
    };

Cast _$CastFromJson(Map<String, dynamic> json) => Cast(
      json['id'] as int,
      json['name'] as String,
      json['profile_path'] as String?,
    );

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
    };
