import 'package:json_annotation/json_annotation.dart';

part 'movieless_model.g.dart';

@JsonSerializable()
class MovieLess {
  MovieLess(
    this.id,
    this.title,
    this.backdropPath,
    this.voteAverage,
  );

  final int id;
  final String title;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  factory MovieLess.fromJson(Map<String, dynamic> json) =>
      _$MovieLessFromJson(json);

  Map<String, dynamic> toJson() => _$MovieLessToJson(this);
}
