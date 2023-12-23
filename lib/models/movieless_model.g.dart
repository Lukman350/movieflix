// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movieless_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieLess _$MovieLessFromJson(Map<String, dynamic> json) => MovieLess(
      json['id'] as int,
      json['title'] as String,
      json['backdrop_path'] as String?,
      (json['vote_average'] as num).toDouble(),
    );

Map<String, dynamic> _$MovieLessToJson(MovieLess instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'backdrop_path': instance.backdropPath,
      'vote_average': instance.voteAverage,
    };
